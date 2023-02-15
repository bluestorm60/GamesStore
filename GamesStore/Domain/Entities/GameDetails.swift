//
//  GameDetails.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation

struct GameDetails: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let title: String?
    let gameImge: String?
    let gameDescription: String?
    let redditUrl: String?
    let gameWebSite: String?
}
