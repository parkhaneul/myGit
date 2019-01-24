//
//  LoadDataViewController.swift
//  myGit
//
//  Created by 박하늘 on 22/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class LoadDataViewController : UIViewController{
    //var repoData : [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
            login access
        */
        /*GithubAPI(authentication : authentication).getUserReposByToken(completion: {(response, error) in
            if let response = response{
                let data = try! JSONSerialization.jsonObject(with: response, options: .mutableContainers) as! [JSON]
                for repos in data{
                    self.repoData.append(Repository(repos))
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "homeSegue", sender: self)
                }
            } else{
                print(error ?? "")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "failSegue", sender: self)
                }
            }
        })*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegue(withIdentifier: "homeSegue", sender: self)
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        let navi = segue.destination as! UINavigationController
        let tab = navi.viewControllers[0] as! UITabBarController
        let repo = tab.viewControllers![0] as! HomeViewController
        repo.repoData = self.repoData*/
    }*/
}
