//
//  JobsListRouter.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

protocol JobsListRouter: BaseRouter {
    func openDetail(vacancyItem: VacancyEntity)
}

class JobsListRouterImp: JobsListRouter {
    
    weak var view: UIViewController!
    
    init(_ view: JobsListViewController) {
        self.view = view
    }
    
    func openDetail(vacancyItem: VacancyEntity) {
        JobsDetailConfiguratorImp.open(navigationController: view.navigationController!, vacancyItem: vacancyItem)
    }
    
}
