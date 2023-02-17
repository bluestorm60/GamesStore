//
//  GamesListCoordinator.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

protocol GamesListBaseCoordinator: Coordinator {}

class GamesListCoordinator: GamesListBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let container = AppDIContainer()
        let cache = CoreDataGamesResponseStorage()
        let repo = DefaultGamesRepository(dataTransferService: container.apiDataTransferService, cache: cache)
        let useCase = DefaultSearchGamesUseCase(gamesRepository: repo)
        let viewModel = DefaultGamesListViewModel(searchGamesUseCase: useCase, coordinator: self)
        rootViewController = UINavigationController(rootViewController: GamesListViewController(viewModel: viewModel))
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
//        switch flow {
//        case .orders(let screen):
//            handleOrdersFlow(for: screen, userData: userData)
//        default:
//            parentCoordinator?.moveTo(flow: flow, userData: userData)
//        }
    }
    
//    private func handleOrdersFlow(for screen: OrdersScreen, userData: [String : Any]? = nil) {
//        switch screen {
//        case .firstScreen:
//            resetToRoot(animated: false)
//        case .secondScreen:
//            handleGoToSecondScreen()
//        case .thirdScreen:
//            handleGoToThirdScreen()
//        }
//    }
    
//    private func handleGoToSecondScreen() {
//        resetToRoot(animated: false)
//        navigationRootViewController?.pushViewController(Orders2ViewController(coordinator: self), animated: false)
//
//    }
    
//    private func handleGoToThirdScreen() {
//        resetToRoot(animated: false)
//        navigationRootViewController?.pushViewController(Orders2ViewController(coordinator: self), animated: false)
//        navigationRootViewController?.pushViewController(Orders3ViewController(coordinator: self), animated: false)
//
//    }
   
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}
