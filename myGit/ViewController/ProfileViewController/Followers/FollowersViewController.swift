//
//  File.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class FollowersViewController : UITableViewController{
    var data : [Owner] = []
    var userData : [Users] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFollowers()
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerCell", for: indexPath) as? FollowersViewCell
        
        if indexPath.row < userData.count {
            cell?.setData(userData[indexPath.row])
        }
        return cell!
    }
    
    func loadFollowers(){
        showSpinner(onView: self.view)
        GithubAPI().getFollowers { (response, error) in
            if let response = response{
                for json in response.toJsonArray(){
                    let user = Owner(json)
                    self.data.append(user)
                }
                
                if self.data.isEmpty{
                    self.stopSpinner()
                }
                
                for user in self.data{
                    self.loadUser(login: user.get("login") as! String)
                }
            } else{
                ConnectFailViewController.showErrorView(self)
            }
        }
    }
    
    func loadUser(login : String){
        GithubAPI().getUserByLoginString(login) { (response, error) in
            self.stopSpinner()
            if let response = response{
                self.userData.append(Users(response.toJson()))
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
