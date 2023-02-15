//
//  GamesResponseStorage.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation

protocol GamesResponseStorage {
    func getResponse(for request: GamesRequestDTO, completion: @escaping (Result<GamesResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: GamesResponseDTO, for requestDto: GamesRequestDTO)
}
