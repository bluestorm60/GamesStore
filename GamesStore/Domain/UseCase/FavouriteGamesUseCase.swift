//
//  FavouriteGamesUseCase.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation
protocol FavouriteGamesUseCase{
    func fetchFavouriteGamesList(cached: @escaping ([Game]) -> Void)
    func saveFavouriteGame(game: Game, completion: ((Error?) -> Void)?)
    func removeFavouriteGame(game:Game, completion: ((Error?) -> Void)?)
    func isFavourited(game:Game,cached: @escaping (Bool) -> Void)
}

final class DefaultFavouriteGamesUseCase:FavouriteGamesUseCase{
    
    private let favouriteRepo: GamesFavouriteRespository
    init(favouriteRepo: GamesFavouriteRespository) {
        self.favouriteRepo = favouriteRepo
    }
    
    func fetchFavouriteGamesList(cached: @escaping ([Game]) -> Void) {
        return favouriteRepo.fetchFavouriteGamesList(cached: cached)
    }
    
    func saveFavouriteGame(game: Game, completion: ((Error?) -> Void)?) {
        favouriteRepo.saveFavouriteGame(game: game,completion: completion)
    }
    
    func removeFavouriteGame(game: Game, completion: ((Error?) -> Void)?) {
        favouriteRepo.removeFavouriteGame(game: game,completion: completion)
    }
    
    func isFavourited(game: Game, cached: @escaping (Bool) -> Void) {
        favouriteRepo.isFavourited(game: game, cached: cached)
    }

}
