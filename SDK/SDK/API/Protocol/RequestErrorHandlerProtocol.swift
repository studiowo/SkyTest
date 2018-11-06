//
//  RequestErrorHandlerProtocol.swift
//  SDK
//
//  Created by Renato Matos on 24/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation

public protocol RequestErrorHandlerProtocol {
    func handleErrorResult(_ errorResult: ErrorResult)
}
