//
//  ViewController+Extension.swift
//  Clean_VK
//
//  Created by Alan on 25/05/2019.
//  Copyright © 2019 Alan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: view controller not found in \(name) storyboard")
        }
    }
}
