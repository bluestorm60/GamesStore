//
//  GameDetailsUseCase.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

protocol GameDetailsUseCase {
    func getGameDetails(gameId: Int,completion: @escaping (Result<GameDetails, Error>) -> Void) -> Cancellable?
    func saveFavouriteGame(game: Game, completion: ((Error?) -> Void)?)
    func removeFavouriteGame(game:Game, completion: ((Error?) -> Void)?)
    func isFavourited(game:Game,cached: @escaping (Bool) -> Void)
}

final class DefaultGameDetailsUseCase: GameDetailsUseCase {
    
    

    private let gamesRepository: GameDetailsRepository

    init(gamesRepository: GameDetailsRepository) {

        self.gamesRepository = gamesRepository
    }
    
    func getGameDetails(gameId: Int, completion: @escaping (Result<GameDetails, Error>) -> Void) -> Cancellable? {
        return gamesRepository.getGameDetails(gameID: gameId) { result in
            completion(result)
        }
    }
    
    func saveFavouriteGame(game: Game, completion: ((Error?) -> Void)?) {
        gamesRepository.saveFavouriteGame(game: game,completion: completion)
    }
    
    func removeFavouriteGame(game: Game, completion: ((Error?) -> Void)?) {
        gamesRepository.removeFavouriteGame(game: game,completion: completion)
    }
    
    func isFavourited(game: Game, cached: @escaping (Bool) -> Void) {
        gamesRepository.isFavourited(game: game, cached: cached)
    }

}
