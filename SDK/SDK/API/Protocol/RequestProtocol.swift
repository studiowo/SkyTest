//
//  RequestProtocol.swift
//  SDK
//
//  Created by Renato Matos on 24/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation
import Alamofire

public typealias Success<T: Codable> = (_ response: T) -> ()
public typealias Failure = (_ error: ErrorResult) -> ()

protocol RequestProtocol {
    func request<T>(requestConvertible: URLRequestConvertible, success: @escaping Success<T>, failure: @escaping Failure)
}
