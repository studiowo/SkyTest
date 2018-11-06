//
//  SDKClient.swift
//  SDK
//
//  Created by Renato Matos on 24/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation
import Alamofire

public protocol SDKStyle {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var titleFont: UIFont { get }
    var descriptionFont: UIFont { get }
}

public class SDKClient {
    public static let shared: SDKClient = SDKClient()

    private var didStartConfig: (() -> Void)? = nil
    private var didFinishConfig: (() -> Void)? = nil
    private var didFinishError: (() -> Void)? = nil

    private let accessCode: String = "1234567890"
    var environment: SDKEnvironment?
    
    var baseUrl: String {
        let base = SDKClient.shared.environment?.urlEnvironment.baseURL ?? ""
        let version = SDKClient.shared.environment?.urlEnvironment.version ?? ""
        return "\(base)\(version)/"
    }

    func setup(with environment: SDKEnvironment, didStartConfig: (() -> Void)? = nil, didFinishConfig: (() -> Void)? = nil, didFinishError: (() -> Void)? = nil) {
        self.didStartConfig = didStartConfig
        self.didFinishConfig = didFinishConfig
        self.didFinishError = didFinishError

        self.environment = environment
        self.setupApiClient()
    }

    private func setupApiClient() {
        guard let environment = self.environment, let accessIsValid = self.accessCodeIsValid() else {
            fatalError("Environment SDK should not be nil 😑")
        }

        if accessIsValid {
            debugPrint("Configuration SDK has been started... ⚙️")

            Api.shared.setupClient(with: "\(environment.urlEnvironment.baseURL)/\(environment.urlEnvironment.version)", didFinishConfig: self.didFinishConfig ?? {
                debugPrint("Configuration SDK has been finished successfully... ✅")
                }, didFinishError: self.didFinishError)
            return
        }

        fatalError("Access code is Invalid 😑")
    }

    private func accessCodeIsValid() -> Bool? {
        guard let environment = self.environment else {
            fatalError("Environment SDK should not be nil 😑")
        }

        return environment.accessCode.elementsEqual(self.accessCode)
    }
}
