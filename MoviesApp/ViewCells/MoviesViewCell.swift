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

            moviesImage.loadFrom(url: url)
                }
}

