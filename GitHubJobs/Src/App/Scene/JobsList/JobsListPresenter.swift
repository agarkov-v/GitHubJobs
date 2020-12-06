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
    func scrollToRow()
}

protocol JobsListPresenter {
    
//    var vacancyCount: Int { get }
    func viewDidLoad()
    func reloadData()
    func loadData()
    func hasMorePage() -> Bool
    
    var vacancyForDayCount: Int { get }
    func vacancyInSectionCount(_ sectionIndex: Int) -> Int
    func setupJobsListCell(cell: JobsListCellView, indexPath: IndexPath)
    func setupJobsHeaderCell(cell: JobsListHeaderCellView, section: Int)
    func openDetail(at indexPath: IndexPath)
}

class JobsListPresenterImp: JobsListPresenter {
    
    private weak var view: JobsListView!
    private let router: JobsListRouter
    private var disposeBag = DisposeBag()
//    private var vacancyItems = [VacancyEntity]()
    private let vacancyUseCase: VacancyUseCase
    
//    var vacancyCount: Int {
//        vacancyItems.count
//    }
    
    
    //----------
    private var vacancyForDay = [VacancyForDayEntity]()
    
    var vacancyForDayCount: Int {
        vacancyForDay.count
    }
    
    func vacancyInSectionCount(_ sectionIndex: Int) -> Int {
        vacancyForDay[sectionIndex].vacancyes.count
    }
    
    func formatUTCDate(_ text: String) -> Date {
        let dateString = text.replacingOccurrences(of: " UTC", with: "")
        let dateFormatter = DateFormatUtil.convertDateFormatToDate(dateString: dateString, fromFormat: "EEE MMM d HH:mm:ss yyyy", toFotmat: "dd/MM/yyyy")
        guard let formattedDate = dateFormatter else { return Date() }
        return formattedDate
    }
    
    func configurVacancyforDay(vacancy: [VacancyEntity]) {
        var vacancyForDayDict: [Date: [VacancyEntity]] = [Date: [VacancyEntity]]()
        vacancyForDayDict = Dictionary(grouping: vacancy, by: { self.formatUTCDate($0.createdAt!)})
        
//        for (key, value) in vacancyForDayDict {
//            self.vacancyForDay.append(VacancyForDayEntity(date: key, vacancyes: value))
//        }
        vacancyForDayDict.forEach { (date, vacancyes) in
            self.vacancyForDay.append(VacancyForDayEntity(date: date, vacancyes: vacancyes))
        }
        
        vacancyForDay.sort(by: { $0.date > $1.date })
    }
    
    func setupJobsListCell(cell: JobsListCellView, indexPath: IndexPath) {
        cell.setupCell(vacancy: vacancyForDay[indexPath.section].vacancyes[indexPath.row])
    }
    
    func setupJobsHeaderCell(cell: JobsListHeaderCellView, section: Int) {
        cell.setupCell(date: vacancyForDay[section].date)
    }
    
    
    //----------
    
    init(_ view: JobsListView,
         _ router: JobsListRouter,
         _ vacancyUseCase: VacancyUseCase) {
        self.view = view
        self.router = router
        self.vacancyUseCase = vacancyUseCase
        subscribe()
    }
    
    private func subscribe() {
        _ = vacancyUseCase.source
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (vacancyItems) in
                guard let self = self else { return }
//                self.vacancyItems = vacancyItems
                //добавлять элементы или очищать и опять добавлять
                if !self.vacancyForDay.isEmpty {
                    self.vacancyForDay.removeAll()
                }
                self.configurVacancyforDay(vacancy: vacancyItems)
//                self.view.scrollToRow()
                self.view.reloadTable()
//                self.view.scrollToRow()
            })
    }
    
    private func reset() {
        self.vacancyUseCase.reset()
        self.disposeBag = DisposeBag()
        self.view.reloadTable()
    }
    
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
    
    func hasMoreItems() -> Bool {
        return vacancyUseCase.hasMorePage
    }
    
    func viewDidLoad() {
        loadData()
    }
    
    func reloadData() {
        vacancyForDay.removeAll()
        reset()
        loadData()
    }
    
    func openDetail(at indexPath: IndexPath) {
        router.openDetail(vacancyItem: vacancyForDay[indexPath.section].vacancyes[indexPath.row])
    }
    
    func hasMorePage() -> Bool {
        vacancyUseCase.hasMorePage
    }

}
