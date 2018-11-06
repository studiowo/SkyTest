//
//  ViewCodeProtocol.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import Foundation

protocol ViewCodeProtocol {
    func setupViews()
    func configViews()
    func buildViews()
    func configConstraints()
}

extension ViewCodeProtocol {
    func setupViews() {
        configViews()
        buildViews()
        configConstraints()
    }
}
