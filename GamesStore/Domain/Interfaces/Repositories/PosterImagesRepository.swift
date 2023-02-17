//
//  PosterImagesRepository.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import Foundation

protocol PosterImagesRepository {
    func fetchImage(with imagePath: String, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
