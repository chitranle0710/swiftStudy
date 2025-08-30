//
//  Constants.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation

struct Constants {
    struct API {
        // Replace with your actual API key from TMDb
        static let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NGIwMTkyNmZhYTg2ODRlMmJiY2ZkZTI4ZTgwNTZkOSIsIm5iZiI6MTc0OTcxNjc2OC4xNDksInN1YiI6IjY4NGE4ZjIwNzBlODY4Yjg4MGIwZDNiNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7DDv7c1TnQJn7KI9gAbBK-8R37JOBt7eQmB9-nqlePM"
        static let imageBaseURL = "https://image.tmdb.org/t/p/"
    }
    
    struct ImageSize {
        static let poster = "w500"
        static let backdrop = "original"
    }
}
