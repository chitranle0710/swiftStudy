//
//  MovieDetail.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation

struct MovieDetail: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String
    let runtime: Int?
    let genres: [Genre]
    let budget: Int
    let revenue: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres, budget, revenue
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let urlString = Constants.API.imageBaseURL + Constants.ImageSize.poster + posterPath
        return URL(string: urlString)
    }
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        let urlString = Constants.API.imageBaseURL + Constants.ImageSize.backdrop + backdropPath
        return URL(string: urlString)
    }
    
    var formattedRuntime: String {
        guard let runtime = runtime else { return "N/A" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
}

struct Genre: Identifiable, Decodable {
    let id: Int
    let name: String
}
