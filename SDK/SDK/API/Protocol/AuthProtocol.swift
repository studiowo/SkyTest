//
//  AuthProtocol.swift
//  SDK
//
//  Created by Renato Matos on 25/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation

public protocol AuthProtocol {
    func needsAuthenticate(success: () -> Void)
}
