//
//  MovieCardView.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie // Your Movie model should have id, title, posterPath, voteAverage

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 120, height: 180)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 180)
                        .clipped()
                        .cornerRadius(12)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 180)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }

            Text(movie.title)
                .font(.headline)
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .padding(.top, 4)

            if let rating = movie.voteAverage {
                Text("⭐️ \(String(format: "%.1f", rating))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 140)
    }
}
