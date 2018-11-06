//
//  Toggable.swift
//  SDK
//
//  Created by Renato Matos on 24/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation

public enum FeatureMap {
    case primeiroAcesso
    case login
    case cadastro
    case esqueciSenha
    case solicitarCartao
    case acompanharProposta
    case resgatePontos
    case resgateDesconto
    case resgateMilhas
    case resgateSmiles
    case resgateAzul
    case faturaPorEmail
    case desbloqueio

    private var Key: String {
        switch self {
        case .primeiroAcesso:
            return "PrimeiroAcesso"
        case .login:
            return "Login"
        case .cadastro:
            return "Cadastro"
        case .esqueciSenha:
            return "EsqueciSenha"
        case .solicitarCartao:
            return "SolicitarCartao"
        case .acompanharProposta:
            return "acompanharProposta"
        case .resgatePontos:
            return "ResgatePontos"
        case .resgateDesconto:
            return "ResgateDesconto"
        case .resgateMilhas:
            return "ResgateMilhas"
        case .resgateSmiles:
            return "ResgateSmiles"
        case .resgateAzul:
            return "ResgateAzul"
        case .faturaPorEmail:
            return "FaturaPorEmail"
        case .desbloqueio:
            return "Desbloqueio"
        }
    }
}

internal struct Feature {
    let name: String
    let isOn: Bool
}

public extension FeatureMap {
    func isAvailable(featureAvailable: (Bool) -> Void, notFound: (() -> Void)? = nil) {
        checkAvailability(featureAvailable: { (isAvailable) in
            featureAvailable(isAvailable)
        }) {
            notFound?()
        }
    }
}

internal extension FeatureMap {
    internal func checkAvailability(featureAvailable: (Bool) -> Void, notFound: (() -> Void)? = nil) {
        let mapFeature = [
            Feature(name: "Login", isOn: true),
            Feature(name: "PrimeiroAcesso", isOn: true),
            Feature(name: "Cadastro", isOn: true),
            Feature(name: "LembrarSenha", isOn: true),
            Feature(name: "Desbloqueio", isOn: true),
            Feature(name: "FaturaEmail", isOn: true)
        ]

        guard let feature = mapFeature.filter({ $0.name.elementsEqual(self.Key) }).first else {
            notFound?()
            return
        }

        feature.isOn ? featureAvailable(true) : featureAvailable(false)
    }
}
