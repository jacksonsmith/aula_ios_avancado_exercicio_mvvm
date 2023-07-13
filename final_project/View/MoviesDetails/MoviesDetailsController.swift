//
//  MoviesDetailsController.swift
//  final_project
//
//  Created by Jackson on 16/08/22.
//

import Foundation
import UIKit

class MovieDetailsController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    var viewModel: MovieDetailsViewModel?
    var movieId: String
    
    lazy var mainTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.accessibilityIdentifier = "movie_title"
        
        view.text = movie?.title
        view.textColor = .black
        
        return view
    }()
    
    lazy var voteAverage: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.text = String(movie?.voteAverage ?? 0.0)
        view.textColor = .black
                
        return view
    }()
    
    
    lazy var voteCount: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.text = String(movie?.voteCount ?? 0)
        view.textColor = .black
        
        return view
    }()
    
    
    lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        
        view.style = .large
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.startAnimating()
        
        return view
        
    }()
    
    var movie: MovieDetails? {
        return viewModel?.movie
    }
    
    init(movieId: String) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        view.addSubview(mainTitle)
        view.addSubview(voteAverage)
        view.addSubview(voteCount)
        
        setupConstraints()
        bindSetup()
        
        // HIGHLIGHT -> COnstruir a tela
        viewModel?.fetchMovie(movieId: movieId)
    }
    
    func setupConstraints() {
        mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        voteAverage.topAnchor.constraint(equalTo: mainTitle.topAnchor, constant: 40).isActive = true
        voteAverage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        voteAverage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        voteCount.topAnchor.constraint(equalTo: voteAverage.topAnchor, constant: 40).isActive = true
        voteCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        voteCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
    }
    
    func bindSetup() {
        viewModel = MovieDetailsViewModel(model: MovieDetailsModel())
        viewModel?.updateMovieDetails = updateScreen
        
        viewModel?.showLoading = self.showLoading
        viewModel?.hideLoading = self.hideLoading
    }
    
    func updateScreen() {
        DispatchQueue.main.async { [weak self] in
            self?.mainTitle.text = "Título: \(self?.viewModel?.movie?.title ?? "")"
            self?.voteAverage.text = "Pontuação Média: \(String(self?.viewModel?.movie?.voteAverage ?? 0.0))"
            self?.voteCount.text = "Total de votos: \(String(self?.viewModel?.movie?.voteCount ?? 0))"
        }
    }
    
    func showLoading() {
        view.addSubview(spinner)
        
        spinner.heightAnchor.constraint(equalToConstant: 200).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 200).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.spinner.removeFromSuperview()
        }
    }
}
