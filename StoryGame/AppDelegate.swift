//
//  AppDelegate.swift
//  StoryGame
//
//  Created by Harold Davidson on 4/22/25.
//

import UIKit
import AVFoundation

var backgroundMusic: AVAudioPlayer?
let path = Bundle.main.path(forResource: "background_music.mp3", ofType:nil)!
let url = URL(fileURLWithPath: path)

// 1. Delete Main Storyboard
// 2. Project > Info > delete Scene Manifest
// 3. Project > Build Settings > search "Main" > delete UIMainStoryboardFile: Main for Release and Debug

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let homeVC = HomeVC()
        let baseNavigationController = SwipeNavigationController(rootViewController: homeVC)
        baseNavigationController.navigationBar.barStyle = .black
        UINavigationBar.appearance().tintColor = .white
        
        window.rootViewController = baseNavigationController
        self.window = window
        window.makeKeyAndVisible()
        
        // MARK: - Audio
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: url)
            backgroundMusic?.numberOfLoops = -1
            backgroundMusic?.play()
        } catch {
            // couldn't load file :(
            print("failed")
        }
        return true
    }
    
    /// set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
}

