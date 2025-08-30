//
//  APIEndpoints.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation

enum APIEndpoints {
    case trendingMovies
    case movieDetails(id: Int)
    case search(query: String)
    
    private var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    private var path: String {
        switch self {
        case .trendingMovies:
            return "/trending/movie/week"
        case .movieDetails(let id):
            return "/movie/\(id)"
        case .search:
            return "/search/movie"
        }
    }
    
    private var parameters: [String: String] {
        var params = ["api_key": Constants.API.key]
        
        switch self {
        case .search(let query):
            params["query"] = query
        default:
            break
        }
        
        return params
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}
