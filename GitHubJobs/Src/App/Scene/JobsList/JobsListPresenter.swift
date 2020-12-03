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
    
    var vacancyCount: Int { get }
    func viewDidLoad()
    func reloadData()
    func loadData()
    func didSelectRow(at index: Int)
    func setupJobsListCell(cell: JobsListCellView, index: Int)
    func setupJobsHeaderCell(cell: JobsListHeaderCellView, index: Int)
}

class JobsListPresenterImp: JobsListPresenter {
    
    private weak var view: JobsListView!
    private let router: JobsListRouter
    private var disposeBag = DisposeBag()
    private var vacancyItems = [VacancyEntity]()
    private let vacancyUseCase: VacancyUseCase
    
    var vacancyCount: Int {
        vacancyItems.count
    }
    
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
                self.vacancyItems = vacancyItems
                self.view.reloadTable()
            })
    }
    
    func loadData() {
        if self.vacancyItems.isEmpty {
            self.view.showLoaderView()
        }
        if self.vacancyUseCase.hasMorePage {
            self.vacancyUseCase.loadNewData()
                .observeOn(MainScheduler.instance)
                .subscribe(onCompleted: { [weak self] in
                    guard let self = self else { return }
                    self.view.endRefreshing()
                    if self.vacancyItems.isEmpty {
                        self.view.showEmptyMessage(.noData)
                    } else {
                        self.view.clearBackgroundView()
                    }
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.view.showErrorDialog(message: error.localizedDescription)
                    self.view.showEmptyMessage(.somethingWrong)
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
        vacancyUseCase.reset()
        loadData()
    }
    
    func didSelectRow(at index: Int) {
        router.openDetail(vacancyItem: vacancyItems[index])
    }
    
    func setupJobsListCell(cell: JobsListCellView, index: Int) {
        cell.setupCell(vacancy: vacancyItems[index])
    }
    
    func setupJobsHeaderCell(cell: JobsListHeaderCellView, index: Int) {
        cell.setupCell()
    }
}
