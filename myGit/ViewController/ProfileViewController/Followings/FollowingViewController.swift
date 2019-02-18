//
//  FollowingViewController.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class FollowingViewController : UITableViewController{
    var data : [Owner]? = []
    var userData : [Owner] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFollowing()
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingCell", for: indexPath) as? FollowingViewCell
        if indexPath.row < userData.count{
            cell?.setData(userData[indexPath.row])
        }
        return cell!
    }
    
    func loadFollowing(){
        showSpinner(onView: self.view)
        GithubAPI().getFollowing {(following) in
            if let following = following{
                self.data = following
                for user in following{
                    self.loadUser(login: user.login!)
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
