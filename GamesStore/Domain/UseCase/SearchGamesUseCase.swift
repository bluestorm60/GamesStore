//
//  SearchGamesUseCase.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation

protocol SearchGamesUseCase {
    func execute(requestValue: SearchGamesUseCaseRequestValue,
                 cached: @escaping (GamesPage) -> Void,
                 completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchGamesUseCase: SearchGamesUseCase {

    private let gamesRepository: GamesRepository

    init(gamesRepository: GamesRepository) {

        self.gamesRepository = gamesRepository
    }

    func execute(requestValue: SearchGamesUseCaseRequestValue,
                 cached: @escaping (GamesPage) -> Void,
                 completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancellable? {
        return gamesRepository.fetchGamesList(query: requestValue.query, page: requestValue.page, pageSize: requestValue.pageSize, cached: cached) { result in

            completion(result)
        }
    }
}

struct SearchGamesUseCaseRequestValue {
    let query: GameQuery
    let page: Int
    let pageSize: Int
}
