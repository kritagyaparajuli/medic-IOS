//
//  AppDelegate.swift
//  MediCare
//
//  Created by Kritagya Parajuli on 6/27/22.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        UserDefaults.standard.synchronize()
        print("ISLOGGEDIN : \(UserDefaults.standard.bool(forKey: "isLoggedIn"))")
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            let tabBarVC = CustomTabBarController()
            window?.rootViewController = tabBarVC
            window?.makeKeyAndVisible()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

   

}

