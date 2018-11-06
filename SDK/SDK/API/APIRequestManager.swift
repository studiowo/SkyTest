//
//  APIRequestManager.swift
//  SDK
//
//  Created by Renato Matos on 24/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation
import Alamofire

class APIRequestManager : SessionManager {

    public init(configuration :URLSessionConfiguration = URLSessionConfiguration.default, timeout: TimeInterval?, errorHandler: RequestErrorHandlerProtocol?, apiConfig :ServerTrustPolicyManager?) {
        configuration.httpAdditionalHeaders = APIRequestManager.defaultHTTPHeaders

        self.errorHandler = errorHandler

        if let timeout = timeout {
            configuration.timeoutIntervalForRequest = timeout
        }

        if let apiConf = apiConfig{
            super.init(configuration: configuration, serverTrustPolicyManager: apiConf)
        }else{
            super.init(configuration:configuration)
        }
    }

    public typealias NetworkSuccessHandler = (AnyObject?) -> ()
    public typealias NetworkFailureHandler = (HTTPURLResponse?, ErrorResult?) -> ()

    private typealias PendingRequest = () -> ()
    private typealias CompletionHandler = (DataResponse<Any>) -> ()

    private var pendingRequests = Array<PendingRequest>()
    private var isRefreshing = false

    var errorHandler: RequestErrorHandlerProtocol?

}
