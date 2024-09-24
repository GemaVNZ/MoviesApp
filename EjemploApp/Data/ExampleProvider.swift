//
//  ExampleProvider.swift
//  EjemploApp
//
//  Created by Mañanas on 23/9/24.
//

import Foundation

class ExampleProvider {
    
    func searchRecipes (_ query : String) async {
        guard let url = URL(string: "https://dummyjson.com/recipes/search?q=\(query)") else {
            print ("URL not valid")
            recipeList = []
        }
            
        let (data, response) = try await URLSession.shared.data(from:url)
        
    
        let result = try JSONDecoder().decode(Example.self, from:data)
        recipeList = result.recipes
        
        
                
    }
    
}

