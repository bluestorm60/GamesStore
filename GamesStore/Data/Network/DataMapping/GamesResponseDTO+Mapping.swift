//
//  GamesResponseDTO+Mapping.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation

// MARK: - Data Transfer Object

struct GamesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case nextPage = "next"
        case games = "results"
    }
    let nextPage: String?
    let games: [GameDTO]
}

extension GamesResponseDTO {
    struct GameDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case genres
            case metaCritic = "metacritic"
            case backgroundImage = "background_image"
        }
        
        let id: Int
        let name: String?
        let genres: [GenerDTO]
        let metaCritic: Int?
        let backgroundImage: String?
    }
}

extension GamesResponseDTO.GameDTO {
    struct GenerDTO: Decodable{
        private enum CodingKeys: String, CodingKey {
            case name
        }
        let name: String
    }

}

// MARK: - Mappings to Domain

extension GamesResponseDTO {
    func toDomain(page: Int) -> GamesPage {
        return .init(page: page,
                     nextPage: nextPage,
                     games: games.map { $0.toDomain() })
    }
}

extension GamesResponseDTO.GameDTO {
    func toDomain() -> Game {
        return .init(id: Game.Identifier(id),
                     title: name,
                     genres: toDomainGenres(),
                     metaCritic: metaCritic,
                     image: backgroundImage)
    }
    
    func toDomainGenres() -> String {
        return genres.map({$0.name}).joined(separator: ",")
    }
}
