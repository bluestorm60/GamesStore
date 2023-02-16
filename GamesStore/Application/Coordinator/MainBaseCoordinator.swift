//
//  MainBaseCoordinator.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import Foundation
protocol MainBaseCoordinator: Coordinator {
    var gamesCoordinator: GamesListBaseCoordinator { get }
    var favouriteListCoordinator: FavouriteListBaseCoordinator { get }
}

protocol GameBaseCoordinated {
    var coordinator: GamesListBaseCoordinator? { get }
}

protocol FavouriteBaseCoordinated {
    var coordinator: FavouriteListBaseCoordinator? { get }
}
