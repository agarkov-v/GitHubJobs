//
//  JobsDetailPresenter.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation

protocol JobsDetailView: BaseView {
    
    func setupView(_ vacancy: VacancyEntity)
}

protocol JobsDetailPresenter {
    
    func viewDidLoad()
}

class JobsDetailPresenterImp: JobsDetailPresenter {
    
    private weak var view: JobsDetailView!
    private let router: JobsDetailRouter
    private var vacanyItem: VacancyEntity
    
    init(_ view: JobsDetailView,
         _ router: JobsDetailRouter,
         _ vacanyItem: VacancyEntity) {
        self.view = view
        self.router = router
        self.vacanyItem = vacanyItem
    }
    
    func viewDidLoad() {
        view.setupView(vacanyItem)
    }
}
