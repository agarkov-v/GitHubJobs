//
//  ApiBaseGateway.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import RxNetworkApiClient

class ApiBaseGateway {
    
    let apiClient: ApiClient
    
    init(_ apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}
