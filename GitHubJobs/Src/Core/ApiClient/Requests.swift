//
//  Requests.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import Foundation
import RxNetworkApiClient

extension ApiRequest {
    
    static func vacancyRequest(page: Int) -> ApiRequest {
        return request(method: .get, endpoint: .base,
                       query: ("markdown", "true"),
                       ("page", String(page)))
    }
}
