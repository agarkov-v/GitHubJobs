//
//  ApiClient.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation
import Alamofire
import RxSwift

protocol APIClient: class {

    func makeRequest<Request>(with endpoint: Request, completion: @escaping (Result<Request.Response, AFError>) -> Void
    ) where Request: Endpoint
}

class APIClientImp: APIClient {
    
    func makeRequest<Request>(with endpoint: Request, completion: @escaping (Result<Request.Response, AFError>) -> Void) where Request: Endpoint {
        let urlRequest = endpoint.makeRequest()

        urlRequest.response(completionHandler: { data in
            guard let mydata = data.data else {
                completion(.failure(data.error!))
                return
            }

            if let response = endpoint.parseResponse(from: mydata) {
                completion(.success(response))
            } else {
                guard let error = data.error else { return }
                completion(.failure(error))
            }
        }).resume()
    }
}
