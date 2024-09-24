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
    
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            self.navigationItem.title = movie.title
            titleLabel.text = movie.title
            yearLabel.text = movie.year
            runtimeLabel.text = movie.runtime
            directorLabel.text = movie.director
            genreLabel.text = movie.genre
            countryLabel.text = movie.country
            plotTextView.text = movie.plot
            
            if let url = URL(string: movie.poster) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Error al descargar la imagen: \(error?.localizedDescription ?? "Desconocido")")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.moviesImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        } else {
            print("No se recibió ninguna película.")
        }
    }
}
