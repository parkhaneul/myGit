//
//  FollowingViewCell.swift
//  myGit
//
//  Created by 박하늘 on 07/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class FollowingViewCell : UITableViewCell{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    private var _data : Owner?
    var data : Owner?{
        get{
            return _data
        }
        set(newVal){
            _data = newVal
            guard let data = newVal else {
                return
            }
            profileImage.downloaded(from: data.avatar_url!)
            profileImage.circularImage()
            mainLabel.text = data.login!
            subLabel.text = data.name!
        }
    }
    
    func setData(_ user : Owner){
        data = user
    }
}
