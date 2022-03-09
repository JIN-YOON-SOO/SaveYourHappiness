//
//  AppDelegate.swift
//  save your happiness
//
//  Created by 진윤수 on 2022/01/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if UserDefaults.standard.bool(forKey: "lockState") == true {
            window?.rootViewController = LanchLockViewController()
        } else {
            window?.rootViewController = ViewController()
        }
        window?.makeKeyAndVisible()
        return true
    }

    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
}

