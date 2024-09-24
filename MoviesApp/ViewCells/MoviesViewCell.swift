//
//  ListTableViewCell.swift
//  EjemploApp
//
//  Created by Mañanas on 23/9/24.
//

import UIKit

class MoviesViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    
    @IBOutlet weak var moviesImage: UIImageView!
    
    
    @IBOutlet weak var yearLabel: UILabel!

        var task: URLSessionDataTask?

        override func awakeFromNib() {
            super.awakeFromNib()
        }
            
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
            
        func render(movie: Movie) {
            titleLabel.text = movie.title
            yearLabel.text = movie.year
            moviesImage.image = UIImage(named: "image-placeholder")

            task?.cancel()
            
            guard let url = URL(string: movie.poster) else {
                print("URL de imagen inválida")
                return
            }

            task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error al descargar la imagen: \(error?.localizedDescription ?? "Desconocido")")
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self?.moviesImage.image = image
                    }
                }
            }
            task?.resume()
        }
    }

