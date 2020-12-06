//
//  ErrorResponseHandler.swift
//  GitHubJobs
//
//  Created by Вячеслав Агарков on 02.12.2020.
//

import RxNetworkApiClient

open class ErrorResponseHandler: ResponseHandler {
    
    private let jsonDecoder = JSONDecoder()
    
    public func handle<T: Codable>(observer: @escaping SingleObserver<T>,
                                   request: ApiRequest<T>,
                                   response: NetworkResponse) -> Bool {
        
        if let urlResponse = response.urlResponse,
           let nsHttpUrlResponse = urlResponse as? HTTPURLResponse,
           (300..<600).contains(nsHttpUrlResponse.statusCode) {
            let errorEntity = ResponseErrorEntity(response.urlResponse)
            
            #if DEBUG
            errorEntity.errors.append("|| \(nsHttpUrlResponse.statusCode) ||\n")
            #endif
            
            switch nsHttpUrlResponse.statusCode {
            case (300..<400):
                errorEntity.errors.append("Неверный редирект.")
                
            case (400..<500):
                errorEntity.errors.append("Неверный запрос.")
                
            case (500..<600):
                errorEntity.errors.append("Ошибка сервера.")
                
            default:
                errorEntity.errors.append("Неизвестная ошибка.")
            }
            
            observer(.error(errorEntity))
            return true
        } else {
            return true
        }
    }
}

class JsonContentInterceptor: Interceptor {
    
    func prepare<T: Codable>(request: ApiRequest<T>) {
        var headers = request.headers ?? [Header]()
        
        if !headers.contains(Header.acceptJson) {
            headers.append(.acceptJson)
            request.headers = headers
        }
    }
    
    func handle<T: Codable>(request: ApiRequest<T>, response: NetworkResponse) {
        // Noting to do.
    }
}

extension Header: Equatable {
    
    public static func == (lhs: Header, rhs: Header) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}
