//
//  MoviesViewModelMock.swift
//  final_projectTests
//
//  Created by Jackson on 13/07/23.
//

import Foundation

@testable import final_project

class MoviesViewModelMock: MoviesViewModelType {
    func getMovies() {
        self.didCalledGetMovies += 1
    }
    
    
    var model: MoviesModelType
    var service: MoviesServiceType

    var reloadTable: (() -> Void)?
    
    var didCalledInitTimes = 0
    var didCalledGetMovies = 0
    
    required init(model: MoviesModelType, service: MoviesServiceType) {
        self.model = model
        self.service = service
        
        didCalledInitTimes += 1
    }

}
