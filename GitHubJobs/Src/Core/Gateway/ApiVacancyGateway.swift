//
//  ApiVacancyGateway.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import RxSwift

protocol VacancyGateway {
    
    func getVacancy(page: Int) -> Single<PaginationEntity<VacancyEntity>>
}

class ApiVacancyGateway: ApiBaseGateway, VacancyGateway {
    
    func getVacancy(page: Int) -> Single<PaginationEntity<VacancyEntity>> {
        return self.apiClient.execute(request: .vacancyRequest(page: page))
    }
}
