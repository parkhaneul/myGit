//
//  File.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class FollowersViewController : UITableViewController{
    var data : [Owner]? = []
    var userData : [Owner] = []
    
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
        GithubAPI().getFollowers {(followers) in
            if let followers = followers{
                self.data = followers
                for follower in followers{
                    self.loadUser(login: follower.login!)
                }
            }
            self.stopSpinner()
        }
    }
    
    func loadUser(login : String){
        GithubAPI().getUserByLoginString(login){(user) in
            if let user = user{
                self.userData.append(user)
                self.reloadData()
            }
            self.stopSpinner()
        }
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
