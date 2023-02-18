//
//  GamesFavouriteStorage.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 17/02/2023.
//

import Foundation

protocol GamesFavouriteStorage {
    func getFavourites(completion: @escaping (Result<[GamesResponseDTO.GameDTO]?, CoreDataStorageError>) -> Void)
    func save(response: GamesResponseDTO.GameDTO,completion: ((Error?) -> Void)?)
    func delete(response: GamesResponseDTO.GameDTO,completion: ((Error?) -> Void)?)
    func isFavourited(game:GamesResponseDTO.GameDTO,cached: @escaping (Bool) -> Void)

}
