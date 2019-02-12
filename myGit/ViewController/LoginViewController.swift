//
//  LoginViewController.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

var shared_authentication : Authentication = TokenAuthentication(token: auth().access_token)

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
        GithubAPI().getAuth(basicAuth: basicAuth) { (response, Error) in
            if let response = response{
                var authList : [Authorizations] = []
                for auths in response.toJsonArray(){
                    authList.append(Authorizations(auths))
                }
                for auth in authList{
                    let note = auth.get("note") as! String
                    if note == login.authNote.rawValue{
                        self.loginByAuth(basicAuth: basicAuth)
                    } else{
                        self.createAuth(basicAuth: basicAuth)
                    }
                }
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        }
    }
    
    func loginByAuth(basicAuth : BasicAuthentication){
        shared_authentication = basicAuth
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    func createAuth(basicAuth : BasicAuthentication){
        GithubAPI().createNewAuth(basicAuth: basicAuth) { (response, Error) in
            if let response = response{
                self.loginByAuth(basicAuth: basicAuth)
            }
        }
    }
    /*
    func getAuth(basicAuth : BasicAuthentication, client_id : String){
        GithubAPI().getAuth(basicAuth: basicAuth, client_id: client_id) {(response, Error) in
            if let response = response{
                print(response.de)
                //let auth = Authorizations(response.toJson())
                //self.loginByAuth(token: auth.get("token") as! String)
            }
        }
    }
    
    func putAuth(basicAuth : BasicAuthentication, client_id : String){
        GithubAPI().putAuth(basicAuth: basicAuth, client_id: client_id) {(response, Error) in
            if let response = response{
                let auth = Authorizations(response.toJson())
                self.loginByAuth(token: auth.get("token") as! String)
            }
        }
    }*/
}
