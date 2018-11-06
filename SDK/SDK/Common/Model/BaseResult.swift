//
//  BaseResult.swift
//  SDK
//
//  Created by Renato Matos on 26/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation

public enum BaseResult<T> {
    case asSelf(T)
    case asDictionary([String: T])
    case asArray([T])
    case raw(Data)
}
