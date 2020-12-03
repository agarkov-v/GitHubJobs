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
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JobsListConfiguratorImp().configure(view: self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.removeSeparatorsOfEmptyCells()
        registerNib()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    func registerNib() {
        let jobsListNib = R.nib.jobsListCell
        tableView.register(jobsListNib)
        let jobsListHeaderNib = R.nib.jobsListHeaderCell
        tableView.registerHeaderFooterView(jobsListHeaderNib)
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.topItem?.title = "Vacancy List"
    }
    
    @objc private func reloadData() {
        presenter.reloadData()
    }

}

extension JobsListViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: R.reuseIdentifier.jobsListHeaderCell)
//        return view
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //
//    }
    
}

extension JobsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.vacancyCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.jobsListCell, for: indexPath)!
        
        if indexPath.row > self.presenter.vacancyCount - 3 {
            self.presenter.loadData()
        }
        
        presenter.setupJobsListCell(cell: cell, index: indexPath.row)
        return UITableViewCell()
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
