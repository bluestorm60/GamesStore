//
//  GamesListItemViewModel.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import Foundation


class GamesListItemViewModel {
    let title: String?
    let genres: String?
    let metaCritic: Int?
    let image: String?
    var selected = false
    init(game: Game) {
        self.title = game.title ?? ""
        self.genres = game.genres ?? "-"
        self.metaCritic = game.metaCritic ?? 0
        self.image = game.image
    }
}
