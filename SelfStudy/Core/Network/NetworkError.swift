//
//  NetworkError.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
    case serverError(Int)
    case unknown
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from the server"
        case .invalidData:
            return "Invalid data received"
        case .decodingError:
            return "Error decoding the data"
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}
