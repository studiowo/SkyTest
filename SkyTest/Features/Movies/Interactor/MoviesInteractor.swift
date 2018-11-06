//
//  MoviesInteractor.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import Foundation
import SDK

class MoviesInteractor {
    func getMoviews(success: @escaping ([MovieModel]) -> Void, failure: @escaping (String) -> Void) {
        MovieModel.request(with: MovieRouter.list, onSuccess: { (result) in
            if case let .asArray(model) = result {
                success(model)
            }
        }, onError: { (error) in
            failure(error.mensagem)
        })
    }
}
