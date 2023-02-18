//
//  GameDetailsRepository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

protocol GameDetailsRepository {
    func getGameDetails(gameID: Int, completion: @escaping (Result<GameDetails,Error>) -> Void) -> Cancellable?
}
