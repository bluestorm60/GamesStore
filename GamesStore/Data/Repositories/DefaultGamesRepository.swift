//
//  DefaultGamesRepository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation

final class DefaultGamesRepository {

    private let dataTransferService: DataTransferService
    private let cache: GamesResponseStorage

    init(dataTransferService: DataTransferService, cache: GamesResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultGamesRepository: GamesRepository {
    func fetchGamesList(query: GameQuery, page: Int, pageSize: Int, cached: @escaping (GamesPage) -> Void, completion: @escaping (Result<GamesPage, Error>) -> Void) -> Cancellable? {
        let requestDTO = GamesRequestDTO(query: query.query, page: page, pageSize: pageSize)
        let task = RepositoryTask()
        
        cache.getResponse(for: requestDTO) { result in
            if case let .success(responseDTO?) = result {
                cached((responseDTO.toDomain(page: requestDTO.page)))
            }else{
                guard !task.isCancelled else {return}
                let endPoint = APIEndpoints.getGames(with: requestDTO)
                task.networkTask = self.dataTransferService.request(with: endPoint, completion: { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let responseDTO):
                        self.cache.save(response: responseDTO, for: requestDTO)
                        completion(.success(responseDTO.toDomain(page: requestDTO.page)))
                    }
                })
            }
        }
        return task
    }
    
}
