//
//  HomeViewCustomCell.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class HomeViewCustomCell : UITableViewCell{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var state: UILabel!
    
    var data : Repository = Repository([:])
    
    func setData(_ repo : Repository){
        data = repo
        let user = Owner(data.get("owner") as! JSON)
        profileImage.downloaded(from: user.get("avatar_url") as! String)
        profileImage.circularImage()
        setState()
        nameText.text = data.get("full_name") as? String
        mainText.text = data.get("description") as? String
        let date = repo.get("updated_at") as! String
        dateText.text = date.dateCalcul()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setState(){
        var st = data.get("state") as! String
        if st == "Owner"{
            state.textColor = UIColor.gray
        } else if st == "Starred"{
            st = st + " ★"
            state.textColor = UIColor.blue
        } else {
            st = st + " ꆳ"
            state.textColor = UIColor.green
        }
        state.text = st
    }
}


