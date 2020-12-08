//
//  JobsListPresenter.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation
import RxSwift

protocol JobsListView: BaseView {
    
    func reloadTable()
    func endRefreshing()
    func showLoaderView()
    func showEmptyMessage(_ stubType: StubType)
    func clearBackgroundView()
}

protocol JobsListPresenter {
    
    var vacancyForDayCount: Int { get }
    var shouldReloadData: PublishSubject<Void> { get }
    func viewDidLoad()
    func reloadData()
    func vacancyInSectionCount(_ sectionIndex: Int) -> Int
    func setupJobsListCell(cell: JobsListCellView, indexPath: IndexPath)
    func setupJobsHeaderCell(cell: JobsListHeaderCellView, section: Int)
    func openDetail(at indexPath: IndexPath)
    func loadData()
    func hasMorePage() -> Bool
}

class JobsListPresenterImp: JobsListPresenter {
    
    // MARK: - Private Properties
    private weak var view: JobsListView!
    private let router: JobsListRouter
    private let vacancyInteractor: VacancyInteractor
    private var disposeBag = DisposeBag()
    private var vacancyForDay = [VacancyForDayModel]()
    private let dateFormatterUtil: DateFormatterUtil
    private var state: VacancyState = .empty

    // MARK: - Public Properties
    let shouldReloadData = PublishSubject<Void>()
    var vacancyForDayCount: Int {
        vacancyForDay.count
    }
    
    init(_ view: JobsListView, _ router: JobsListRouter, _ dateFormatterUtil: DateFormatterUtil, _ vacancyInteractor: VacancyInteractor) {
        self.view = view
        self.router = router
        self.dateFormatterUtil = dateFormatterUtil
        self.vacancyInteractor = vacancyInteractor
        stateSubscription()
        vacancySubscription()
    }
    
    // MARK: - Private Methods
    private func configurVacancyForDay(vacancy: [VacancyModel]) {
        var vacancyForDayDict: [Date: [VacancyModel]] = [Date: [VacancyModel]]()
        vacancyForDayDict = Dictionary(grouping: vacancy, by: { dateFormatterUtil.convertDateFormatToDate( dateString: $0.createdAt, fromFormat: "EEE MMM d HH:mm:ss yyyy", toFotmat: "dd/MM/yyyy") })
        
        vacancyForDayDict.forEach { (date, vacancyes) in
            self.vacancyForDay.append(VacancyForDayModel(date: date, vacancyes: vacancyes))
        }
        
        vacancyForDay.sort(by: { $0.date > $1.date })
    }

    private func vacancySubscription() {
        _ = vacancyInteractor.vacansyItems
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (vacancyItems) in
                guard let self = self else { return }
                if !self.vacancyForDay.isEmpty {
                    self.vacancyForDay.removeAll()
                }
                self.configurVacancyForDay(vacancy: vacancyItems)
                if self.vacancyForDay.isEmpty {
                    self.view.showEmptyMessage(.noData)
                }
            })
            .disposed(by: disposeBag)
    }

    private func stateSubscription() {
        vacancyInteractor.didChangeState.subscribe(onNext: { [weak self] vacancyState in
            guard let self = self else { return }

            switch vacancyState {
            case .empty:
                self.state = .empty
            case .loadingData:
                self.state = .loadingData
            case .loadedSomeData:
                self.state = .loadedSomeData
            case .error:
                self.state = .error
            }
            self.shouldReloadData.onNext(())
        }).disposed(by: disposeBag)
    }

    // MARK: - Public Methods
    
    func viewDidLoad() {
        loadData()
    }

    func loadData() {
        if vacancyForDay.isEmpty {
            self.view.showLoaderView()
        }
        if vacancyInteractor.hasMorePage {
            vacancyInteractor.loadPage()
            view.endRefreshing()
            switch state {
            case .empty:
                if let error = vacancyInteractor.error {
                    view.showErrorDialog(message: error.localizedDescription)
                    view.showEmptyMessage(.somethingWrong)
                } else {
                    view.showLoaderView()
                }
            case .error:
                guard let error = vacancyInteractor.error else { return }
                view.showErrorDialog(message: error.localizedDescription)
                view.showEmptyMessage(.somethingWrong)
            default:
                return
            }
        }
    }
    
    func reloadData() {
        vacancyForDay.removeAll()
        vacancyInteractor.reset()
        loadData()
        view.reloadTable()
        view.endRefreshing()
    }
    
    func vacancyInSectionCount(_ sectionIndex: Int) -> Int {
        vacancyForDay[sectionIndex].vacancyes.count
    }

    func setupJobsListCell(cell: JobsListCellView, indexPath: IndexPath) {
        cell.setupCell(vacancy: vacancyForDay[indexPath.section].vacancyes[indexPath.row])
    }
    
    func setupJobsHeaderCell(cell: JobsListHeaderCellView, section: Int) {
        cell.setupCell(date: vacancyForDay[section].date, dateFormatterUtil: dateFormatterUtil)
    }
    
    func openDetail(at indexPath: IndexPath) {
        router.openDetail(vacancyItem: vacancyForDay[indexPath.section].vacancyes[indexPath.row])
    }

    func hasMorePage() -> Bool {
        vacancyInteractor.hasMorePage
    }
}
