//
//  Router.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/11.
//

import UIKit

final class Router {

    static let shared = Router()

    private(set) var window: UIWindow!
    private var navController: UINavigationController {
        window.rootViewController as! UINavigationController
    }
    func navigateToRoot(with window: UIWindow) {
        self.window = window
        window.rootViewController = UINavigationController(rootViewController: CopyViewController())
        window.makeKeyAndVisible()
    }
}
