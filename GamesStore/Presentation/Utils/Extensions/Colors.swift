//
//  Colors.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 17/02/2023.
//

import UIKit

enum AssetsColor {
    case selectedColor
}

extension UIColor {
    
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .selectedColor:
            return UIColor(named: "SelectedColor")!
        }
    }
}
