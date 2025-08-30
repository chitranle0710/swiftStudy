//
//  MovieViewModel.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: IMovieRepository
    
    init(repository: IMovieRepository = MovieRepository()) {
        self.repository = repository
    }
    
    func fetchingMovie() {
        isLoading = true
        errorMessage = nil
        
        repository.getTrendingMovies().receive(on: DispatchQueue.main)
            .sink {
                [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.errorMessage = error.message
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }.store(in: &cancellables)
    }
}
