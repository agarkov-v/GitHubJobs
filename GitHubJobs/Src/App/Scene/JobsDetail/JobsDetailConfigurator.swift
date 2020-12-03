//
//  JobsDetailConfigurator.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

class JobsDetailConfiguratorImp {
    
    func configure(view: JobsDetailViewController, vacancyItem: VacancyEntity) {
        let router = JobsDetailRouterImp(view)
        let presenter = JobsDetailPresenterImp(view, router, vacancyItem)
        view.presenter = presenter
    }
    
    static func open(navigationController: UINavigationController, vacancyItem: VacancyEntity) {
        let view = R.storyboard.jobsDetail.jobsDetailVC()!
        JobsDetailConfiguratorImp().configure(view: view, vacancyItem: vacancyItem)
        navigationController.pushViewController(view, animated: true)
    }
}
