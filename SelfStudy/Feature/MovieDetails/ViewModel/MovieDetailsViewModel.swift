//
//  MovieDetailsViewModel.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation
import Combine

class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: IMovieRepository
    
    init(repository: IMovieRepository = MovieRepository()) {
        self.repository = repository
    }
    
    func fetchMovieDetails(for movieId: Int) {
        isLoading = true
        errorMessage = nil
        
        repository.getMovieDetails(id: movieId).receive(on: DispatchQueue.main)
            .sink {
                [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.errorMessage = error.message
                }
            } receiveValue: {  [weak self] detail in
                self?.movieDetail = detail
            }
            .store(in: &cancellables)
    }
}
