//
//  DefaultGameDetailsRepository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

final class DefaultGameDetailsRepository {

    private let dataTransferService: DataTransferService
    private let cache: GamesFavouriteStorage


    init(dataTransferService: DataTransferService, cache: GamesFavouriteStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultGameDetailsRepository: GameDetailsRepository{
    func saveFavouriteGame(game: Game, completion: ((Error?) -> Void)?) {
        cache.save(response: game.toData(),completion: completion)
    }
    
    func removeFavouriteGame(game: Game, completion: ((Error?) -> Void)?) {
        cache.delete(response: game.toData(),completion: completion)
    }
    
    func isFavourited(game: Game, cached: @escaping (Bool) -> Void) {
        cache.isFavourited(game: game.toData()) { isFav in
            cached(isFav)
        }
    }
    
    
    func getGameDetails(gameID: Int, completion: @escaping (Result<GameDetails, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        
                guard !task.isCancelled else {return task}
                let endPoint = APIEndpoints.getGameDetails(with: gameID)
                task.networkTask = self.dataTransferService.request(with: endPoint, completion: { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let responseDTO):
                        completion(.success(responseDTO.toDomain()))
                    }
                })
    
        return task

    }
    
    
}
