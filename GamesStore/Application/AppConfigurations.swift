//
//  AppConfigurations.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 14/02/2023.
//

import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        return "\(Config.configURL(key: .ApiKey))"
    }()
    lazy var apiBaseURL: String = {
        return "https://\(Config.configURL(key: .baseURL))/"
    }()
}
