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

import GifWalletKit

class Wireframe {

    init() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = UIColor.GifWallet.brand
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.barStyle = .black
    }

    func initialViewController() -> UIViewController {
        let dataStore = DataStore()
        let interactor = GIFWalletViewController.Interactor(dataStore: dataStore)
        let vc = GIFWalletViewController(interactor: interactor)
        let navigationController = UINavigationController(rootViewController: vc)
        return navigationController
    }

}
