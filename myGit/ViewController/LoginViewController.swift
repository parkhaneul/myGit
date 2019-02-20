//
//  LoginViewController.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController : UIViewController{
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchLogo(_ sender: Any) {
        checkAuth()
    }
    
    func checkAuth(){
        let basicAuth = BasicAuthentication(username: idText.text!, password: passText.text!)
        GithubAPI.API.getAuth(basicAuth: basicAuth)
        .subscribe{
            guard let list = $0.element else{
                self.createAuth(basicAuth: basicAuth)
                return
            }
            for auth in list{
                if auth.note == login.authNote.rawValue{
                    self.loginByAuth(basicAuth: basicAuth)
                    break
                }
                else if auth == list.last{
                    self.createAuth(basicAuth: basicAuth)
                }
            }
        }.disposed(by: disposebag)
    }
    
    func loginByAuth(basicAuth : BasicAuthentication){
        shared_authentication = basicAuth
        toSegue()
    }
    
    func createAuth(basicAuth : BasicAuthentication){
        GithubAPI.API.createNewAuth(basicAuth: basicAuth)
        .subscribe{
            guard $0.element != nil else{
                return
            }
            self.loginByAuth(basicAuth: basicAuth)
            self.toSegue()
        }.disposed(by: disposebag)
    }
    
    func toSegue(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
}
