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
    
    enum ownerShip : String{
        case owner = "Owner"
        case starred = "Starred"
        case forks = "Forks"
    }
    
    private var _data : Repository?
    var data : Repository?{
        get{
            return _data
        }
        set(newVal){
            _data = newVal
            guard let data = newVal else{
                return
            }
            let user = data.owner!
            let date = data.updated_at!
            profileImage.downloaded(from: user.avatar_url!)
            profileImage.circularImage()
            nameTextChange(text: data.full_name!)
            mainTextChnage(text: data.decription ?? "")
            dateTextChange(text: date)
        }
    }
    
    func setData(_ repo : Repository){
        self.data = repo
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func dateTextChange(text : String){
        dateText.text = text.dateCalcul()
    }
    
    func mainTextChnage(text : String){
        mainText.text = text
    }
    
    func nameTextChange(text : String){
        nameText.text = text
    }
    
    func setState(owner : ownerShip){
        var st = owner.rawValue
        if owner == ownerShip.owner{
            state.textColor = UIColor.gray
        } else if owner == ownerShip.starred{
            st = st + " ★"
            state.textColor = UIColor.blue
        } else {
            st = st + " ꆳ"
            state.textColor = UIColor.green
        }
        state.text = st
    }

}


