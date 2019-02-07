//
//  FollowersViewCell.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class FollowersViewCell : UITableViewCell{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    var data = Users([:])
    
    func setData(_ user : Users){
        data = user
        profileImage.downloaded(from: data.get("avatar_url") as! String)
        profileImage.circularImage()
        mainLabel.text = data.get("login") as! String
        subLabel.text = data.get("name") as! String
    }
}
