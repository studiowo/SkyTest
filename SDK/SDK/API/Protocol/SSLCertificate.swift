//
//  SSLCertificate.swift
//  SDK
//
//  Created by Renato Matos on 27/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Security

public protocol SSLCertificate {
    var certificateBytes: [UInt8] { get }
    func certificate() -> SecCertificate?
}

extension SSLCertificate {
    public func certificate() -> SecCertificate? {
        let data = Data(bytes: certificateBytes, count: certificateBytes.count)
        let secCertificate: SecCertificate? = SecCertificateCreateWithData(nil, data as CFData)
        return secCertificate
    }
}
