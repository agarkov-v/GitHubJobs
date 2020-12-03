//
//  DI.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import DITranquillity
import RxNetworkApiClient

class DI {
    
    private static var container = DIContainer()
    
    static func initDependencies() {
        
        // MARK: - Interceptors
        self.container.register(ExtendedLoggingInterceptor.init)
            .as(ExtendedLoggingInterceptor.self)
            .lifetime(.single)

        // MARK: - Handlers
        self.container.register(ErrorResponseHandler.init)
            .as(ErrorResponseHandler.self)
            .lifetime(.single)
        
       // MARK: ApiClient
        ApiEndpoint.baseEndpoint = ApiEndpoint.base
        self.container.register { () -> ApiClientImp in
            let client = ApiClientImp.defaultInstance(host: ApiEndpoint.base.host)
//            client.interceptors.removeAll()
            client.responseHandlersQueue.append(ErrorResponseHandler())
            client.interceptors.append(ExtendedLoggingInterceptor())
            return client
        }
        .as(ApiClient.self)
//        .injection(cycle: true) {
//            $0.interceptors.insert($1 as ExtendedLoggingInterceptor, at: 0)
//        }
//        .injection(cycle: true) {
//            $0.responseHandlersQueue.insert($1 as ErrorResponseHandler, at: 0)
//        }
        .lifetime(.single)
        
        // MARK: - Gateways
        self.container.register(ApiVacancyGateway.init)
            .as(VacancyGateway.self)
            .lifetime(.single)
        
        // MARK: - UseCases
        self.container.register(VacancyUseCaseImp.init)
            .as(VacancyUseCase.self)
    
    }
    
    static func resolve<T>() -> T {
        return self.container.resolve()
    }
}
