//
//  VacancyEndpoint.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation
import Alamofire

class VacancyEndpoint: Endpoint {

    typealias Response = [VacancyModel]

    let page: APIPageModel

    init(page: APIPageModel) {
        self.page = page
    }
    
    func makeRequest() -> DataRequest {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "jobs.github.com"
        components.path = "/positions.json"

        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page.page)"),
            URLQueryItem(name: "markdown", value: "true")
        ]

        let url = components.url!

        let alamoRequest = AF.request(url)

        return alamoRequest
    }

    func parseResponse(from data: Data) -> Response? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(Response.self, from: data)
        } catch let error {
            debugPrint(">>>>>>>>>> \nparseResponse error: \(error) || \(error.localizedDescription) \n<<<<<<<<<<")
            return nil
        }
    }
}

