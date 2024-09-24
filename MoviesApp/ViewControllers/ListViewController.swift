//
//  ListViewController.swift
//  EjemploApp
//
//  Created by Mañanas on 23/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UISearchBar!
    
    var moviesList: [Movie] = []
    var moviesInitialList: [Movie] = []
    var movie: Movie!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        searchButton.delegate = self
        
        self.navigationItem.title = "Movies"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesViewCell
        let movie = moviesList[indexPath.row]
        cell.render(movie: movie)
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Texto de búsqueda actual: '\(searchText)'")
        
        guard !searchText.isEmpty else {
            moviesList = moviesInitialList
            tableView.reloadData()
            print("Texto de búsqueda vacío. Lista reseteada a la inicial.")
            return
        }
        
        MoviesProvider.shared.searchMovies(by: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.moviesList = movies
                    self?.moviesInitialList = movies // Guarda la lista inicial
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error al buscar películas: \(error.localizedDescription)")
                    self?.moviesList = []
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigateToDetail" {
            let viewController = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            viewController.movie = moviesList[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}
