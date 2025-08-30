//
//  APIClient.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation
import Combine
import Alamofire

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    func fetch<T: Decodable>(endpoint: APIEndpoints) -> AnyPublisher<T, NetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .get,
                          headers: [
                            "Authorization": "Bearer \(Constants.API.key)",
                            "accept": "application/json"
                          ])
        .validate()
        .publishDecodable(type: T.self)
        .value()
        .mapError { afError in
            switch afError {
            case .responseValidationFailed(let reason):
                if case .unacceptableStatusCode(let code) = reason {
                    return NetworkError.serverError(code)
                }
                return NetworkError.invalidResponse
            case .responseSerializationFailed:
                return NetworkError.decodingError
            default:
                return NetworkError.unknown
            }
        }
        .eraseToAnyPublisher()
    }
}
