//
//  MovieModel.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import Foundation
import SDK

struct MovieModel: Codable, Fetchable {
    let id: String
    let title: String
    let overview: String
    let duration: String
    let release_year: String
    let cover_url: String
    let backdrops_url: [String]
}
