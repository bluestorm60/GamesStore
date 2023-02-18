//
//  AppCoordinator.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import UIKit

protocol MainCoordinator{
    var navigationController: UINavigationController? {get}
    var rootViewController: UIViewController? {get}
    func start()
}

final class AppCoordinator: MainCoordinator{
    var rootViewController: UIViewController? = UITabBarController()
    
    var navigationController: UINavigationController?
    

    func start() {
        let gameCoordinator = GameListCoordinator()
        gameCoordinator.start()
        let gameListNav = gameCoordinator.navigationController
        
        gameListNav?.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "gamesUnSelected_ic"),selectedImage: UIImage(named: "gamesSelected_ic"))
        
        let gameFavCoordinator = GamesFavouriteCoordinator()
        gameFavCoordinator.start()
        let gameFavNav = gameFavCoordinator.navigationController

        
        gameFavNav?.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "favUnSelected_ic"),selectedImage: UIImage(named: "favSelected_ic"))
        (rootViewController as? UITabBarController)?.tabBar.backgroundColor = UIColor.white
        (rootViewController as? UITabBarController)?.tabBar.layer.borderWidth = 0.50
        (rootViewController as? UITabBarController)?.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        (rootViewController as? UITabBarController)?.viewControllers = [gameCoordinator.navigationController!,gameFavCoordinator.navigationController!]
    }
    
    
}



