//
//  AppDelegate.swift
//  GifWallet
//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    private let wireframe = Wireframe()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        defer { self.window?.makeKeyAndVisible() }
        
        guard NSClassFromString("XCTest") == nil else {
            self.window?.rootViewController = UIViewController()
            return true
        }

        IQKeyboardManager.shared().isEnabled = true
        self.window?.rootViewController = wireframe.initialViewController()

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
        let navigationController = UINavigationController(rootViewController: GIFWalletViewController())
        return navigationController
    }

}
