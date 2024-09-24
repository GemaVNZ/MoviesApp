//
//  ExampleProvider.swift
//  EjemploApp
//
//  Created by Mañanas on 23/9/24.
//

import Foundation

class MoviesProvider {
    
    static let shared = MoviesProvider()
    
    private init() {}
    
    func searchMovies(by title: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(Constants.API_BASE_URL)?s=\(title)&apikey=\(Constants.API_ACCESS_TOKEN)"
        guard let url = URL(string: urlString) else {
            print("URL inválida.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No se pudo obtener datos."])))
                return
            }
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                completion(.success(searchResponse.movies))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func searchMoviesByimdbID(by id: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        let urlString = "\(Constants.API_BASE_URL)?i=\(id)&apikey=\(Constants.API_ACCESS_TOKEN)"
        guard let url = URL(string: urlString) else {
            print("URL inválida.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibió ningún dato"])
                completion(.failure(error))
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(movie))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
}
