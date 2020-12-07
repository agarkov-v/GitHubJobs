//
//  VacancyApiService.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation
import RxSwift

protocol VacancyApiService {

    func getVacancy(page: APIPageEntity, completion: @escaping (Result<[VacancyEntity], Error>) -> Void)
}

class VacancyApiServiceImp: VacancyApiService {

    // MARK: - Private Properties
    private let apiClient: APIClient

    // MARK: - Init
    init(apiClient: APIClient = APIClientImp()) {
        self.apiClient = apiClient
    }

    // MARK: - Public Properties

    func getVacancy(page: APIPageEntity, completion: @escaping (Result<[VacancyEntity], Error>) -> Void) {
        let endpoint = VacancyEndpoint(page: page)
        apiClient.makeRequest(with: endpoint, completion: completion)
    }
}
