//
//  Config.swift
//  Nahdi
//
//  Created by Ahmed Shafik on 31/07/2022.
//

import Foundation
enum AppEnvironment: String {
    case dev = "DEVELOPMENT"
    case production = "PRODUCTION"
    case unknown
}


public enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist not found")
        }
        return dict
    }()
    
    static func configURL(key: Config.Keys) -> String{
        guard let baseURL = Config.infoDictionary[key.rawValue] as? String else {
            fatalError("Base URL not set in plist")
        }
        return baseURL
    }
    
    static var appEnvironment: AppEnvironment{
        get{
            return AppEnvironment(rawValue: Config.configURL(key: .environment)) ?? .unknown
        }
    }
    
    enum Keys: String {
        case environment = "ENVIRONMENT"
        case baseURL = "BASE_URL"
        case ApiKey = "API_KEY"
    }
}
