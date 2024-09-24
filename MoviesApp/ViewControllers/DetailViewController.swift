//
//  DetailViewController.swift
//  EjemploApp
//
//  Created by Mañanas on 23/9/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var moviesImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var plotTextView: UITextView!
    
    var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovieDetails(id: movie.imdbID)
    }
    
    func fetchMovieDetails(id: String) {
        MoviesProvider.shared.searchMoviesByimdbID(by: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetails):
                    self?.movie = movieDetails
                    self?.updateUI()
                case .failure(let error):
                    print("Error al obtener detalles de la película: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateUI() {
        titleLabel.text = movie.title
        yearLabel.text = movie.year
        plotTextView.text = movie.plot ?? "Sin descripción disponible."
        runtimeLabel.text = movie.runtime ?? "Duración no disponible."
        genreLabel.text = movie.genre ?? "Género no disponible."
        countryLabel.text = movie.country ?? "País no disponible."
        

        if let url = URL(string: movie.poster) {
            moviesImageView.loadFrom(url: url)
        }
    }
}
