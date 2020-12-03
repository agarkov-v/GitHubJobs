//
//  JobsDetailRouter.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import UIKit

protocol JobsDetailRouter: BaseRouter {
    
}

class JobsDetailRouterImp: JobsDetailRouter {
    
    weak var view: UIViewController!
    
    init(_ view: JobsDetailViewController) {
        self.view = view
    }
    
}
