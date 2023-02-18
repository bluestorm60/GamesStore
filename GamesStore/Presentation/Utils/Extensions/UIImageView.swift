//
//  UIImageView.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func load(url: URL) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage{
            self.image = image
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {[weak self] in
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
