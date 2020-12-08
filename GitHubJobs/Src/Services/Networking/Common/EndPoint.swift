//
//  EndPoint.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation
import Alamofire

protocol Endpoint {
    
    associatedtype Response

    func makeRequest() -> DataRequest

    func parseResponse(from data: Data) -> Response?
}
