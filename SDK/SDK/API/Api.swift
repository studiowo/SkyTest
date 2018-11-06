//
//  Api.swift
//  SDK
//
//  Created by Renato Matos on 02/08/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation
import Alamofire

class Api {

    static let shared = Api()
    private let client = ApiClient.shared

    private var didFinishConfig: (() -> Void)? = nil
    private var didFinishError: (() -> Void)? = nil

    func setupClient(with baseUrl: String, didFinishConfig: (() -> Void)? = nil, didFinishError: (() -> Void)? = nil) {
        guard let environment = SDKClient.shared.environment else {
            fatalError("Environment SDK should not be nil 😑")
        }

        self.didFinishConfig = didFinishConfig
        self.didFinishError = didFinishError

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.httpCookieAcceptPolicy = .always
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.urlCache = nil
        configuration.tlsMinimumSupportedProtocol = .tlsProtocol12

        let base = SDKClient.shared.environment?.urlEnvironment.baseURL ?? ""
        let version = SDKClient.shared.environment?.urlEnvironment.version ?? ""
        let baseUrl = "\(base)\(version)/"

        let serverTurstPolicies: [String: ServerTrustPolicy] = [
            baseUrl: .pinCertificates(
                certificates: environment.urlEnvironment.sslCertificates.compactMap { $0.certificate() },
                validateCertificateChain: true,
                validateHost: true
            )
        ]

        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTurstPolicies)

        self.client.setupClient(configuration: configuration, baseURL: baseUrl, timeout: 5, errorHandler: self, apiConfig: serverTrustPolicyManager)
        self.didFinishConfig?()
    }
}

extension Api: RequestErrorHandlerProtocol {
    func handleErrorResult(_ errorResult: ErrorResult) {

    }
}
