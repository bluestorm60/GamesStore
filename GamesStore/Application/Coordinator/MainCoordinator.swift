//
//  MainCoordinator.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

enum AppFlow {
    case games(GameScreen)
    case favourite(FavouriteScreen)
}

enum GameScreen {
    case openDetails
}

enum FavouriteScreen {
    case openDetails
}

class MainCoordinator: MainBaseCoordinator {
    

    var parentCoordinator: MainBaseCoordinator?
    
    lazy  var gamesCoordinator: GamesListBaseCoordinator = GamesListCoordinator()
    lazy var favouriteListCoordinator: FavouriteListBaseCoordinator = FavouriteListCoordinator()
    
    lazy var rootViewController: UIViewController  = UITabBarController()
    
    func start() -> UIViewController {
        
        let gamesListViewController = gamesCoordinator.start()

        gamesCoordinator.parentCoordinator = self
        gamesListViewController.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "gamesUnSelected_ic"),selectedImage: UIImage(named: "gamesSelected_ic"))

        
        let favouriteListViewController = favouriteListCoordinator.start()

        favouriteListCoordinator.parentCoordinator = self
        
        favouriteListViewController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "favUnSelected_ic"),selectedImage: UIImage(named: "favSelected_ic"))
        
        (rootViewController as? UITabBarController)?.viewControllers = [gamesListViewController,favouriteListViewController]
                
        return rootViewController
    }
        
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .favourite:
            goToFavourtiesFlow(flow)
        case .games:
            goToGamesFlow(flow)
        }
    }
    
    private func goToFavourtiesFlow(_ flow: AppFlow) {
        favouriteListCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
        
    }
    
    private func goToGamesFlow(_ flow: AppFlow) {
        gamesCoordinator.moveTo(flow: flow, userData: nil)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
        
    }
    
    
    func resetToRoot() -> Self {
        gamesCoordinator.resetToRoot(animated: false)
        moveTo(flow: .games(.openDetails), userData: nil)
        return self
    }
    
}
