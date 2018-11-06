//
//  SDKEnvironment.swift
//  SDK
//
//  Created by Renato Matos on 24/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import UIKit

public struct SDKEnvironment {
    public typealias URLEnvironment = (baseURL: String, version: String, clientSecret: String, clientID: String, sslCertificates: [SSLCertificate])

    let urlEnvironment: URLEnvironment
    let accessCode: String
    let window: UIWindow
    let authProtocol: AuthProtocol

    public init(urlEnvironment: URLEnvironment, accessCode: String, window: UIWindow, authProtocol: AuthProtocol) {
        self.urlEnvironment = urlEnvironment
        self.accessCode = accessCode
        self.window = window
        self.authProtocol = authProtocol
    }

    public func setup() {
        SDKClient.shared.setup(with: self)
    }
}
