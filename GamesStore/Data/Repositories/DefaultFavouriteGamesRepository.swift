//
//  DefaultFavouriteGamesRepository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

final class DefaultFavouriteGamesRepository {

    private let cache: GamesFavouriteStorage

    init(cache: GamesFavouriteStorage) {
        self.cache = cache
    }
}

extension DefaultFavouriteGamesRepository: GamesFavouriteRespository {
    func fetchFavouriteGamesList(cached: @escaping ([Game]) -> Void){
        cache.getFavourites { result in
            if case let .success(responseDTO) = result {
                if let games = responseDTO?.map({$0.toDomain()}) {
                    cached(games)
                }else{
                    cached([])
                }
            }
        }
    }
    
    func saveFavouriteGame(game: Game) {
        cache.save(response: game.toData())
    }
    
    func removeFavouriteGame(game: Game) {
        cache.delete(response: game.toData())
    }
    
}
