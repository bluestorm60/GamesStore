//
//  GamesFavouriteRespository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

protocol GamesFavouriteRespository {
    @discardableResult
    func fetchFavouriteGamesList(cached: @escaping ([Game]) -> Void)
    func saveFavouriteGame(game: Game)
    func removeFavouriteGame(game:Game)
//    func fetchGameDetails(id: GameDetailsRequest,
//                         cached: @escaping (GameDetails) -> Void,
//                         completion: @escaping (Result<GameDetails, Error>) -> Void) -> Cancellable?

}
