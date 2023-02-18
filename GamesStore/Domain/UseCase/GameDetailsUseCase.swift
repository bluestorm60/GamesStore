//
//  GameDetailsUseCase.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

protocol GameDetailsUseCase {
    func getGameDetails(gameId: Int,completion: @escaping (Result<GameDetails, Error>) -> Void) -> Cancellable?
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
}
