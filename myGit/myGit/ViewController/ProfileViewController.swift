//
//  ProfileViewController.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class ProfileViewController : UITableViewController{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var followings: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var user : Users = Users([:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GithubAPI().getUserByToken(completion: {(response, error) in
            if let response = response{
                self.user = Users(response.toJson())
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.updateUserInfo()
                }
            } else{
                print(error ?? "")
            }
        })
    }
    
    func updateUserInfo(){
        self.profileImage.downloaded(from: user.data["avatar_url"] as! String)
        self.profileImage.circularImage().setBorder(width: 2, color: UIColor.white.cgColor)
        self.name.text = user.data["name"] as? String
        self.fullName.text = user.data["company"] as? String
        self.followers.text = "followers" + String(user.data["followers"] as! Int)
        self.followings.text = "following" + String(user.data["following"] as! Int)
    }
}
