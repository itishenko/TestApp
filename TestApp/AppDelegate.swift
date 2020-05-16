//
//  AppDelegate.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let container = DependencyContainer()
        self.window?.rootViewController = container.buildMainModule()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
