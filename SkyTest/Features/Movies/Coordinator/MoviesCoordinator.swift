//
//  MoviesCoordinator.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesCoordinatorProtocol {
    func getListMoviews(success: @escaping ([MovieModel]) -> Void, failure: @escaping (String) -> Void)
    func selectMovie(model: MovieModel)
}

class MoviesCoordinator {
    var rootViewController: UINavigationController?
    var movieSelected: MovieModel?
    let interactor = MoviesInteractor()
    
    static func start() -> MoviesCoordinator {
        let coordinator = MoviesCoordinator()
        let controller = ListMoviesViewController(with: coordinator)
        coordinator.rootViewController = UINavigationController(rootViewController: controller)
        
        return coordinator
    }
    
    private func showDetailMovie() {
        guard let movieSelected = self.movieSelected else {
            fatalError("Flow not permited")
        }
        
        let controller = DetailMovieViewController(with: self, movieModel: movieSelected)
        self.rootViewController?.pushViewController(controller, animated: true)
    }
}

//MARK: Coordinator Protocol
extension MoviesCoordinator: MoviesCoordinatorProtocol {
    func selectMovie(model: MovieModel) {
        self.movieSelected = model
        self.showDetailMovie()
    }
    
    func getListMoviews(success: @escaping ([MovieModel]) -> Void, failure: @escaping (String) -> Void) {
        self.interactor.getMoviews(success: { (model) in
            success(model)
        }) { (error) in
            failure(error)
        }
    }
}
