//
//  GameDetailsResponseDTO+Mapping.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

struct GameDetailsResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title = "name"
        case backgroundImage = "background_image"
        case gameDescription = "description"
        case redditUrl = "reddit_url"
        case website
    }
    
    let id: Int
    let title: String?
    let backgroundImage: String?
    let gameDescription: String?
    let redditUrl: String?
    let website: String?
}

extension GameDetailsResponseDTO{
    func toDomain() -> GameDetails{
        return .init(id: String(id), title: title, gameImge: backgroundImage, gameDescription: gameDescription, redditUrl: redditUrl, gameWebSite: website)
    }
}
