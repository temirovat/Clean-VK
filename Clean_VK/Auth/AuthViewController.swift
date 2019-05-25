//
//  AuthViewController.swift
//  Clean_VK
//
//  Created by Alan on 25/05/2019.
//  Copyright © 2019 Alan. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AppDelegate.shared().authService
    }
    


}
