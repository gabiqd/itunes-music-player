//
//  Utils.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 23/05/2021.
//

import Foundation
import UIKit

extension UIColor {
    static let customWhite = UIColor(named: "customWhite")
    static let customBlack = UIColor(named: "customBlack")
}

@nonobjc
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
