//
//  Coordinator.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    func moveTo(flow: AppFlow, userData: [String: Any]?)
    @discardableResult func resetToRoot(animated: Bool) -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}