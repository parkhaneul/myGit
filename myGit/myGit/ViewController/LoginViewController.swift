//
//  LoginViewController.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

let shared_authentication : Authentication = TokenAuthentication(token: auth().access_token)

class LoginViewController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchLogo(_ sender: Any) {
        self.performSegue(withIdentifier: "accessSeuge", sender: self)
    }
}
