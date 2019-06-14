//
//  AppDelegate.swift
//  Clean_VK
//
//  Created by Alan on 24/05/2019.
//  Copyright © 2019 Alan. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {

    var window: UIWindow?
    public var authService: AuthService!

    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        authService = AuthService()
        authService.authDelegate = self
        
        let authVC: AuthViewController = AuthViewController.loadFromStoryboard()
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    // MARK: - Auth Delegate
    func authServiceShouldShow(_ viewController: UIViewController) {
        print("authServiceShouldShow")
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        print("authServiceSignIn")
        let feedVC: NewsfeedViewController = NewsfeedViewController.loadFromStoryboard()
        let navigationFeedVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navigationFeedVC
    }
    
    func authServiceDidSignInFail() {
        print("authServiceDidSignInFail")
    }

}

