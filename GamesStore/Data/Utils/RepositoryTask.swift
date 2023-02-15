//
//  RepositoryTask.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
