//
//  ApiClient.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 06.12.2020.
//

import Foundation

protocol APIClient: class {

    func makeRequest<Request>(with endpoint: Request, completion: @escaping (Result<Request.Response, Error>) -> Void
    ) where Request: Endpoint
}

class APIClientImp: APIClient {
    
    func makeRequest<Request>(with endpoint: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) where Request: Endpoint {
        let urlRequest = endpoint.makeRequest()

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIClientError.unknownError))
                return
            }

            if let response = endpoint.parseResponse(from: data) {
                completion(.success(response))
            } else {
                completion(.failure(error!))
            }
        }.resume()
    }
}

enum APIClientError: Error {
    case unknownError
}
