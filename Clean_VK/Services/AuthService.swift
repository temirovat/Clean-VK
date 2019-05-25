//
//  AuthService.swift
//  Clean_VK
//
//  Created by Alan on 24/05/2019.
//  Copyright © 2019 Alan. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
    func authServiceSignIn()
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    weak var authDelegate: AuthServiceDelegate?
    
    private let vkSDK: VKSdk
    private let authVC: AuthViewController = AuthViewController()
    
    private enum AuthService {
        static let appId = "6673708"
    }
    
    private enum AuthState  {
        case authorized
        case initialized
        case error
    }
    
    override init() {
        vkSDK = VKSdk.initialize(withAppId: AuthService.appId)
        super.init()
        
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { [authDelegate] (state, error) in
            switch state {
            case .authorized:
                print("VKAuthorizationState.autorized")
                authDelegate?.authServiceSignIn()
            case .initialized:
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            case .error:
                print("Error: \(String(describing: error)), state: \(state )")
                authDelegate?.authServiceDidSignInFail()
            case .unknown:
                print("VKAuthorizationState.unknown")
            case .pending:
                print("VKAuthorizationState.pending")
            case .external:
                print("VKAuthorizationState.external")
            case .safariInApp:
                print("VKAuthorizationState.safariInApp")
            case .webview:
                print("VKAuthorizationState.webview")
            }
        }
    }
    
    // MARK: - VKSdkDelegate

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            authDelegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: - VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        authDelegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
