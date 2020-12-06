//
//  ApiVacancyGateway.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import RxSwift

protocol VacancyGateway {
    
    func getVacancy(page: Int) -> Single<[VacancyEntity]>
}

class ApiVacancyGateway: ApiBaseGateway, VacancyGateway {
    
    func getVacancy(page: Int) -> Single<[VacancyEntity]> {
        return self.apiClient.execute(request: .vacancyRequest(page: page))
    }
}
