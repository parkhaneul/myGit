//
//  LoginViewController.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController{
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchLogo(_ sender: Any) {
        checkAuth()
    }
    
    func checkAuth(){
        let basicAuth = BasicAuthentication(username: idText.text!, password: passText.text!)
        GithubAPI().getAuth(basicAuth: basicAuth) { (authorizations) in
            if authorizations != nil{
                self.loginByAuth(basicAuth: basicAuth)
            } else{
                self.createAuth(basicAuth: basicAuth)
            }
        }
    }
    
    func loginByAuth(basicAuth : BasicAuthentication){
        shared_authentication = basicAuth
        toSegue()
    }
    
    func createAuth(basicAuth : BasicAuthentication){
        GithubAPI().createNewAuth(basicAuth: basicAuth) { (authorizations) in
            if authorizations != nil{
                self.loginByAuth(basicAuth: basicAuth)
                self.toSegue()
            }
        }
    }
    
    func toSegue(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
}
