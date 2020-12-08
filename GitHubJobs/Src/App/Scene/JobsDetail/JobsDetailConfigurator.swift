//
//  JobsDetailConfigurator.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

class JobsDetailConfiguratorImp {
    
    func configure(view: JobsDetailViewController, vacancyItem: VacancyModel) {
        let router = JobsDetailRouterImp(view)
        let presenter = JobsDetailPresenterImp(view, router, vacancyItem)
        view.presenter = presenter
        view.dateFormatterUtil = DI.resolve()
    }
    
    static func open(navigationController: UINavigationController, vacancyItem: VacancyModel) {
        let view = R.storyboard.jobsDetail.jobsDetailVC()!
        JobsDetailConfiguratorImp().configure(view: view, vacancyItem: vacancyItem)
        navigationController.pushViewController(view, animated: true)
    }
}
