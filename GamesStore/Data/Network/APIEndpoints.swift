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

    static func getGamePoster() -> Endpoint<Data> {
        return Endpoint(path: "",
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
}
