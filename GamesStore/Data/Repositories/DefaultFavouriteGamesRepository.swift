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
    func isFavourited(game:Game,cached: @escaping (Bool) -> Void){
        cache.isFavourited(game: game.toData()) { result in
            cached(result)
        }
    }

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
    
    func saveFavouriteGame(game: Game, completion: ((Error?) -> Void)?) {
        cache.save(response: game.toData(),completion: completion)
    }
    
    func removeFavouriteGame(game: Game, completion: ((Error?) -> Void)?) {
        cache.delete(response: game.toData(),completion: completion)
    }
    
}
