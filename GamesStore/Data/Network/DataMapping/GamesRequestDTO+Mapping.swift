//
//  GamesRequestDTO+Mapping.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation
struct GamesRequestDTO: Encodable {
    let query: String
    let page: Int
    let pageSize: Int
    enum CodingKeys: String, CodingKey {
        case query = "search"
        case page
        case pageSize = "page_size"
    }
}
