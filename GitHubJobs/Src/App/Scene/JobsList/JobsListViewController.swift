//
//  JobsListViewController.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

class JobsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: JobsListPresenter!
    private var currentIndexPath: IndexPath?
    private var lastSection: Int?
    private var lastRowInSection: Int?
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JobsListConfiguratorImp().configure(view: self)
        prepareTableView()
        registerNib()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.removeSeparatorsOfEmptyCells()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openDetail(at: indexPath)
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
        
        if indexPath.section == numberOfSections(in: tableView) - 1 {
            if indexPath.row > presenter.vacancyInSectionCount(indexPath.section) - 2 {
                presenter.loadData()
                
//                let visibles = tableView.indexPathsForVisibleRows!.sorted()
//                if !visibles.isEmpty {
//                    self.currentIndexPath = visibles[visibles.count / 2]
//                }
                
                lastSection = numberOfSections(in: tableView) - 1
                lastRowInSection = tableView.numberOfRows(inSection: lastSection!)

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
    
    func scrollToRow() {
//        guard let indexPath = currentIndexPath else { return }
//        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
//        currentIndexPath = nil
        guard let lastRowInSection = lastRowInSection, let lastSection = lastSection else { return }
        
        let lastRowIndexPath = IndexPath(row: lastRowInSection, section: lastSection)
        tableView.scrollToRow(at: lastRowIndexPath, at: .middle, animated: true)
        self.lastRowInSection = nil
        self.lastSection = nil

    }
}
