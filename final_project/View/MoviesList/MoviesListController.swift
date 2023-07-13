//
//  ViewController.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import UIKit

// MARK: - Main Class

class MoviesListController: UIViewController, Coordinating, UITableViewDataSource, UITableViewDelegate {
    
    var coordinator: Coordinator?
    var viewModel: MoviesViewModelType!
    
    private var tableView: UITableView = {
        let table =  UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // BIND GET SETUP
    private var data: [Movies] {
        return viewModel.model.movies
    }
    
    // MARK: - Initialize
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupContraints()
        
        bindSetup()
        
        // BIND ASK DATA
        viewModel.getMovies()
    }
    
    // MARK: - Private Functions
    
    private func bindSetup() {
        viewModel.reloadTable = self.reloadTable
    }
    
    private func setupContraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
    }
    
    private func didTapCell(position: IndexPath) {
        let id = String(data[position.row].id)
        
        // WITHOUT COORDINATOR
        // self.present(MovieDetailsController(movieId: id), animated: true)
        coordinator?.navigate(to: .moviesDetails, data: id)
    }
    
    // MARK: - Public Functions
    
    // BIND VIEW - REACTIVE RELOAD FROM VIEW MODEL
    func reloadTable() -> Void {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Data source methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmdbImagePath = "https://image.tmdb.org/t/p/original"
        let currentMovie = data[indexPath.row]
        
        let cell = MoviesItemViewCell(reuseIdentifier: "moviesCell",
                                      imageURL: tmdbImagePath + currentMovie.posterPath,
                                      title: currentMovie.originalTitle)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapCell(position: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
