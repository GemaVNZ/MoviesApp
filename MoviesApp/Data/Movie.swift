//
//  Example.swift
//  EjemploApp
//
//  Created by Mañanas on 23/9/24.
//

import Foundation

struct Movie: Codable {
    let imdbID: String
    let title: String
    let year: String
    let poster: String
    let director: String?
    let plot: String?
    let runtime: String?
    let genre: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case imdbID = "imdbID"
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case director = "Director"
        case plot = "Plot"
        case runtime = "Runtime"
        case genre = "Genre"
        case country = "Country"
    }
}

struct SearchResponse: Codable {
    let movies: [Movie]
    let response: String
    let totalResults: String?

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case response = "Response"
        case totalResults = "totalResults"
    }
}
