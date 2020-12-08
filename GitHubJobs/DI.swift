//
//  DI.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import DITranquillity

class DI {
    
    private static var container = DIContainer()
    
    static func initDependencies() {

        // MARK: - Util
        self.container.register(DateFormatUtilImp.init)
            .as(DateFormatterUtil.self)

        // MARK: - APIClient
        self.container.register(APIClientImp.init)
            .as(APIClient.self)

        // MARK: - APIService
        self.container.register(VacancyApiServiceImp.init)
            .as(VacancyApiService.self)

        // MARK: - Interactor
        self.container.register(VacancyInteractorImp.init)
            .as(VacancyInteractor.self)

    }
    
    static func resolve<T>() -> T {
        return self.container.resolve()
    }
}
