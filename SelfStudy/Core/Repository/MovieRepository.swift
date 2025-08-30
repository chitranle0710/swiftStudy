//
//  MovieRepository.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation
import Combine

protocol IMovieRepository {
    func getTrendingMovies() -> AnyPublisher<[Movie], NetworkError>
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetail, NetworkError>
    func searchMovies(query: String) -> AnyPublisher<[Movie], NetworkError>
}

class MovieRepository: IMovieRepository {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    func getTrendingMovies() -> AnyPublisher<[Movie], NetworkError> {
        return apiClient.fetch(endpoint: .trendingMovies)
            .map { (response: MoviesResponse) -> [Movie] in
                return response.results
            }
            .eraseToAnyPublisher()
    }
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetail, NetworkError> {
        return apiClient.fetch(endpoint: .movieDetails(id: id))
    }
    
    func searchMovies(query: String) -> AnyPublisher<[Movie], NetworkError> {
        return apiClient.fetch(endpoint: .search(query: query))
            .map { (response: MoviesResponse) -> [Movie] in
                return response.results
            }
            .eraseToAnyPublisher()
    }
}
