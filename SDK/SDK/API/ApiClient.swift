//
//  ApiClient.swift
//  SDK
//
//  Created by Renato Matos on 02/08/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation
import Alamofire

public protocol Fetchable {}

public typealias ErrorHandler = (ErrorResult) -> Void
public typealias RefreshHandler = () -> Void
public typealias SuccessHandler<T> = (BaseResult<T>) -> Void where T: Codable

struct ErrorResponse: Codable {
    let fault: ErrorResult
}
struct ErrorAlternativeResponse: Codable {
    let error: String
    let error_description: String
}

class ApiClient {
    
    static let shared = ApiClient()
    
    private var tokenRemaining: Int = 5
    
    private var baseURL: String = ""
    private let hardwareFingerprint: String? = UIDevice.current.identifierForVendor?.uuidString
    
    var requestManager: APIRequestManager?
    var isRefreshToken: Bool = true
    var isLogged: Bool = false
    
    private var errorHandler: RequestErrorHandlerProtocol?
    
    public func setupClient(configuration :URLSessionConfiguration = URLSessionConfiguration.default, baseURL: String, timeout: TimeInterval?, errorHandler: RequestErrorHandlerProtocol?, apiConfig: ServerTrustPolicyManager?){
        self.baseURL = baseURL
        self.requestManager = APIRequestManager(configuration: configuration, timeout: timeout, errorHandler: errorHandler, apiConfig: apiConfig)
    }
    
    func checkTokenRemaining() -> Bool {
        self.tokenRemaining -= 1
        return self.tokenRemaining > 0
    }
}

extension Fetchable where Self: Codable {
    public static func request(with routerData: RouterProtocol, onSuccess: @escaping SuccessHandler<Self>, onError: @escaping ErrorHandler, onRefresh: RefreshHandler? = nil) {
        guard let requestManager = ApiClient.shared.requestManager else {
            return
        }
        
        requestManager.request(Router.request(data: routerData)).responseJSON { responseObj in
            guard let response = responseObj.response else {
                onError(ErrorResult(cod: 0, mensagem: "Opa! Algo deu errado."))
                return
            }
            
            switch responseObj.result {
            case let .success(value):
                switch response.statusCode {
                case 200...209:
                    if let data = responseObj.data {
                        do {
                            let mapped: Self = try JSONDecoder().decode(Self.self, from: data)
                            onSuccess(.asSelf(mapped))
                        } catch {
                            do {
                                let mapped: [Self] = try JSONDecoder().decode([Self].self, from: data)
                                onSuccess(.asArray(mapped))
                            } catch {
                                onSuccess(.raw(data))
                            }
                        }
                    }
                    break
                default:
                    if let dict = value as? NSDictionary {
                        do {
                            let error: ErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: JSONSerialization.data(withJSONObject:dict))
                            onError(ErrorResult(cod: response.statusCode, mensagem: error.fault.mensagem))
                        } catch {
                            do {
                                let error: ErrorAlternativeResponse = try JSONDecoder().decode(ErrorAlternativeResponse.self, from: JSONSerialization.data(withJSONObject:dict))
                                onError(ErrorResult(cod: response.statusCode, mensagem: error.error_description))
                            } catch {
                                onError(ErrorResult(cod: response.statusCode, mensagem: "Opa! Algo deu errado."))
                            }
                        }
                    } else {
                        onError(ErrorResult(cod: response.statusCode, mensagem: "Opa! Algo deu errado."))
                    }
                }
                
                break
            default:
                onError(ErrorResult(cod: response.statusCode, mensagem: "Opa! Algo deu errado."))
                break
            }
        }
    }
}
