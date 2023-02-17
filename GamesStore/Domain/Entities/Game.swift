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
