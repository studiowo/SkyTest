//
//  ErrorResult.swift
//  SDK
//
//  Created by Renato Matos on 24/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation

public enum ErrorType {
    case unauthorized
    case unknown
}

public struct ErrorResult: Codable {
    static var unknown = ErrorResult(mensagem: "Não foi possível processar sua solicitação")

    let cod: String

    public var codigo: Int {
        return Int(cod) ?? 0
    }

    public var mensagem: String

    var errorType: ErrorType {
        switch self.codigo {
        case 401:
            return .unauthorized
        default:
            return .unknown
        }
    }

    init(cod: Int = 0, mensagem: String) {
        self.cod = String(cod)
        self.mensagem = mensagem
    }

    enum CodingKeys: String, CodingKey {
        case cod = "codigo"
        case mensagem = "mensagem"
    }
}

public struct ErrorMensagem: Codable {
    public var mensagem: String
}
