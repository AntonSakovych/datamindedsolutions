//
//  AppDelegate.swift
//  Datamindedsolutions
//
//  Created by Anton Sakovych on 7/1/19.
//  Copyright © 2019 Anton Sakovych. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let vc = ViewController()
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        
        let navigationController = UINavigationController.init(rootViewController: vc)
        
        navigationBarSettings()

        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }
    
    func navigationBarSettings() {
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }

}
