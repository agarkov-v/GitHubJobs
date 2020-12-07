//
//  EndPoint.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation

protocol Endpoint {
    
    associatedtype Response

    func makeRequest() -> URLRequest

    func parseResponse(from data: Data) -> Response?
}
