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
    func viewDidLoad()
    func reloadData()
    func loadData()
    func vacancyInSectionCount(_ sectionIndex: Int) -> Int
    func setupJobsListCell(cell: JobsListCellView, indexPath: IndexPath)
    func setupJobsHeaderCell(cell: JobsListHeaderCellView, section: Int)
    func openDetail(at indexPath: IndexPath)
}

class JobsListPresenterImp: JobsListPresenter {
    
    // MARK: - Private Properties
    private weak var view: JobsListView!
    private let router: JobsListRouter
    private let vacancyUseCase: VacancyUseCase
    private var disposeBag = DisposeBag()
    private var vacancyForDay = [VacancyForDayEntity]()
    
    // MARK: - Public Properties
    var vacancyForDayCount: Int {
        vacancyForDay.count
    }
    
    init(_ view: JobsListView, _ router: JobsListRouter, _ vacancyUseCase: VacancyUseCase) {
        self.view = view
        self.router = router
        self.vacancyUseCase = vacancyUseCase
        subscribe()
    }
    
    // MARK: - Private Methods
    private func subscribe() {
        _ = vacancyUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (vacancyItems) in
                guard let self = self else { return }
                if !self.vacancyForDay.isEmpty {
                    self.vacancyForDay.removeAll()
                }
                self.configurVacancyForDay(vacancy: vacancyItems)
                self.view.reloadTable()
            })
            .disposed(by: disposeBag)
    }
    
    private func reset() {
        self.vacancyUseCase.reset()
        self.view.reloadTable()
    }
    
    private func configurVacancyForDay(vacancy: [VacancyEntity]) {
        var vacancyForDayDict: [Date: [VacancyEntity]] = [Date: [VacancyEntity]]()
        vacancyForDayDict = Dictionary(grouping: vacancy, by: { DateFormatUtil.convertDateFormatToDate( dateString: $0.createdAt, fromFormat: "EEE MMM d HH:mm:ss yyyy", toFotmat: "dd/MM/yyyy") })
        
        vacancyForDayDict.forEach { (date, vacancyes) in
            self.vacancyForDay.append(VacancyForDayEntity(date: date, vacancyes: vacancyes))
        }
        
        vacancyForDay.sort(by: { $0.date > $1.date })
    }
    
    // MARK: - Public Methods
    func loadData() {
        if self.vacancyForDay.isEmpty {
            self.view.showLoaderView()
        }
        if self.vacancyUseCase.hasMorePage {
            self.vacancyUseCase.loadNewData()
                .observeOn(MainScheduler.instance)
                .subscribe(onCompleted: { [weak self] in
                    guard let self = self else { return }
                    self.view.endRefreshing()
                    if self.vacancyForDay.isEmpty {
                        self.view.showEmptyMessage(.noData)
                    } else {
                        self.view.clearBackgroundView()
                    }
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    if error.localizedDescription.contains("operation couldn’t be completed") {
                        self.view.showErrorDialog(message: "Network error")
                        self.view.showEmptyMessage(.networkError)
                    } else {
                        self.view.showErrorDialog(message: error.localizedDescription)
                        self.view.showEmptyMessage(.somethingWrong)
                    }
                    self.view.endRefreshing()
                })
                .disposed(by: disposeBag)
        }
    }
    
    func viewDidLoad() {
        loadData()
    }
    
    func reloadData() {
        vacancyForDay.removeAll()
        reset()
        loadData()
    }
    
    func vacancyInSectionCount(_ sectionIndex: Int) -> Int {
        vacancyForDay[sectionIndex].vacancyes.count
    }
    
    func setupJobsListCell(cell: JobsListCellView, indexPath: IndexPath) {
        cell.setupCell(vacancy: vacancyForDay[indexPath.section].vacancyes[indexPath.row])
    }
    
    func setupJobsHeaderCell(cell: JobsListHeaderCellView, section: Int) {
        cell.setupCell(date: vacancyForDay[section].date)
    }
    
    func openDetail(at indexPath: IndexPath) {
        router.openDetail(vacancyItem: vacancyForDay[indexPath.section].vacancyes[indexPath.row])
    }
}
