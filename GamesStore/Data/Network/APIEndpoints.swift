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

//    static func getGamesDetails(path: String, width: Int) -> Endpoint<Data> {
//
//        let sizes = [92, 154, 185, 342, 500, 780]
//        let closestWidth = sizes.enumerated().min { abs($0.1 - width) < abs($1.1 - width) }?.element ?? sizes.first!
//        
//        return Endpoint(path: "t/p/w\(closestWidth)\(path)",
//                        method: .get,
//                        responseDecoder: RawDataResponseDecoder())
//    }
}
