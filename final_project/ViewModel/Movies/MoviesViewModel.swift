//
//  MoviesViewModel.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import Foundation

protocol MoviesViewModelType {
    init(model: MoviesModelType, service: MoviesServiceType)
    func getMovies()
    
    var model: MoviesModelType { get }
    var service: MoviesServiceType { get }
    
    var reloadTable: (() -> Void)? { get set }
}

class MoviesViewModel: MoviesViewModelType {
    let service: MoviesServiceType
    let model: MoviesModelType
    
    var reloadTable: (() -> Void)?
    
    required init(model: MoviesModelType, service: MoviesServiceType) {
        self.model = model
        self.service = service
    }
    
    func getMovies() {
        service.getMovies { [weak self] data, error in
            self?.model.setMovies(response: data)
            self?.reloadTable?()
        }
    }
}

