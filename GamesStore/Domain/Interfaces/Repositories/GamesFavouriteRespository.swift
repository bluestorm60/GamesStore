//
//  GamesFavouriteRespository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

protocol GamesFavouriteRespository {
    func fetchFavouriteGamesList(cached: @escaping ([Game]) -> Void)
    func saveFavouriteGame(game: Game, completion: ((Error?) -> Void)?)
    func removeFavouriteGame(game:Game, completion: ((Error?) -> Void)?)
    func isFavourited(game:Game,cached: @escaping (Bool) -> Void)
}
