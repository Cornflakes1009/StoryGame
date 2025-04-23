//
//  AppDelegate.swift
//  StoryGame
//
//  Created by Harold Davidson on 4/22/25.
//

import UIKit

// 1. Delete Main Storyboard
// 2. Project > Info > delete Scene Manifest
// 3. Project > Build Settings > search "Main" > delete UIMainStoryboardFile: Main for Release and Debug

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = GameViewController()
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}
