import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var viewModel = MovieDetailsViewModel()

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text("Error")
                        .font(.title)
                    Text(errorMessage)
                        .foregroundColor(.secondary)
                    Button("Retry") {
                        viewModel.fetchMovieDetails(for: movieId)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            } else if let detail = viewModel.movieDetail {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(detail.posterPath ?? "")")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .cornerRadius(12)

                    Text(detail.title)
                        .font(.title)
                        .bold()

                    if let rating = detail.voteAverage {
                        Text("⭐️ \(String(format: "%.1f", rating))/10")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    if let overview = detail.overview {
                        Text(overview)
                            .font(.body)
                            .padding(.top, 4)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Movie Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMovieDetails(for: movieId)
        }
    }
}
