//
//  APIEndpoints.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation

struct APIEndpoints {
    
    static func getGames(with gamesRequestDTO: GamesRequestDTO) -> Endpoint<GamesResponseDTO> {

        return Endpoint(path: "api/games",
                        method: .get,
                        queryParametersEncodable: gamesRequestDTO)
    }

    static func getGameDetails(with gameID: Int) -> Endpoint<GameDetailsResponseDTO> {

        return Endpoint(path: "api/games/\(gameID)",
                        method: .get)
    }

}
