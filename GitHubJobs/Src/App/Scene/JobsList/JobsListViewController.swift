//
//  JobsListViewController.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit
import RxSwift

class JobsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    lazy private var refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    // MARK: - Public Properties
    var presenter: JobsListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JobsListConfiguratorImp().configure(view: self)
        prepareTableView()
        registerNib()
        shouldReload()
        presenter.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    private func shouldReload() {
        presenter.shouldReloadData
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [tableView] in
                tableView?.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
    }
    
    func registerNib() {
        let jobsListNib = R.nib.jobsListCell
        tableView.register(jobsListNib)
        let jobsListHeaderNib = R.nib.jobsListHeaderCell
        tableView.registerHeaderFooterView(jobsListHeaderNib)
    }
    
    func configureNavBar() {
        navigationItem.title = "Vacancy List"
    }
    
    @objc private func reloadData() {
        presenter.reloadData()
    }
    
}

extension JobsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: R.reuseIdentifier.jobsListHeaderCell)!
        presenter.setupJobsHeaderCell(cell: view, section: section)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetail(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension JobsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.vacancyForDayCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.vacancyInSectionCount(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jobsListCell, for: indexPath)!
        
        if indexPath.section == numberOfSections(in: tableView) - 1, presenter.hasMorePage() {
            if indexPath.row > presenter.vacancyInSectionCount(indexPath.section) - 2 {
                presenter.loadData()
            }
        }
        
        presenter.setupJobsListCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension JobsListViewController: JobsListView {
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func showLoaderView() {
        tableView.stubLoading()
    }
    
    func showEmptyMessage(_ stubType: StubType) {
        tableView.stubView(stubType: stubType)
    }
    
    func clearBackgroundView() {
        tableView.hideEmptyMessage()
    }
}
