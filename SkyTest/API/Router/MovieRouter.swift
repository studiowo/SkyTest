//
//  MovieRouter.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import Foundation
import Alamofire
import SDK

enum MovieRouter: RouterProtocol {
    case list
    
    var needsAuth: Bool {
        return true
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "Movies"
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .list:
            return nil
        }
    }
    
    var headers: [String: String]? {
        let defaultHeaders: [String: String] = [:]
        return defaultHeaders
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
