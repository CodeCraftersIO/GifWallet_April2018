//
//  AppDelegate.swift
//  GifWallet
//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    private let wireframe = Wireframe()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        guard NSClassFromString("XCTest") == nil else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = UIViewController()
            self.window?.makeKeyAndVisible()
            return true
        }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = wireframe.initialViewController()
        self.window?.makeKeyAndVisible()

        return true
    }

}

class Wireframe {

    init() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = UIColor.GifWallet.brand
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.barStyle = .black
    }

    func initialViewController() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: WalletViewController())
        return navigationController
    }

}
