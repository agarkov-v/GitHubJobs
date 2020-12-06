//
//  JobsListConfigurator.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit
import RxNetworkApiClient

class JobsListConfiguratorImp {
    
    func configure(view: JobsListViewController) {
        let router = JobsListRouterImp(view)
        let presenter = JobsListPresenterImp(view, router, DI.resolve(), DI.resolve())
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController) {
        let view = R.storyboard.jobsList.jobsListVC()!
        JobsListConfiguratorImp().configure(view: view)
        navigationController.pushViewController(view, animated: true)
    }
}
