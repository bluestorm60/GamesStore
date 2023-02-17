//
//  Game.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation

struct Game: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let title: String?
    let genres: String?
    let metaCritic: Int?
    let image: String?
}

struct GamesPage: Equatable {
    let page: Int
    let nextPage: String?
    let count: Int
    let games: [Game]
}


extension Game {
    func toData() -> GamesResponseDTO.GameDTO{
        return .init(id: Int(id)!, name: title, genres: genres?.components(separatedBy: ",").map({GamesResponseDTO.GameDTO.GenerDTO(name: $0)}) ?? [], metaCritic: metaCritic, backgroundImage: image)
    }
}
