//
//  GamesRepository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation
protocol GamesRepository {
    @discardableResult
    func fetchGamesList(query: GameQuery, page: Int,pageSize: Int,
                         cached: @escaping (GamesPage) -> Void,
                         completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancellable?
//    func fetchGameDetails(id: GameDetailsRequest,
//                         cached: @escaping (GameDetails) -> Void,
//                         completion: @escaping (Result<GameDetails, Error>) -> Void) -> Cancellable?

}
