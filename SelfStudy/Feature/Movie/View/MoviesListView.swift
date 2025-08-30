//
//  MoviesListView.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation
import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading && viewModel.movies.isEmpty {
                    ProgressView("LoadingView...")
                } else if let errorMessage = viewModel.errorMessage, viewModel.movies.isEmpty {
                    VStack {
                        Text("Error")
                            .font(.title)
                        Text(errorMessage)
                            .foregroundColor(.secondary)
                        Button("Try Again") {
                            viewModel.fetchingMovie()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16) {
                            ForEach(viewModel.movies) { movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                    MovieCardView(movie: movie)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }.navigationTitle("Trending Movies")
                .onAppear {
                    if viewModel.movies.isEmpty {
                        viewModel.fetchingMovie()
                    }
                }
        }
    }
}
