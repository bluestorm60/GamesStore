//
//  DefaultGameDetailsRepository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation

final class DefaultGameDetailsRepository {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultGameDetailsRepository: GameDetailsRepository{
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
