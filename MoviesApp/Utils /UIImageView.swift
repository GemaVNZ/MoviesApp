//
//  UIImageView.swift
//  EjemploApp
//
//  Created by Mañanas on 23/9/24.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadFrom(url: URL) {
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            } else {
                print("Error: No se pudo descargar la imagen desde la URL \(url)")
            }
        }
    }
}
