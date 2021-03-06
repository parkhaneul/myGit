//
//  IssueViewCustomCell.swift
//  myGit
//
//  Created by 박하늘 on 22/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class IssueViewCustomCell : UITableViewCell{
    @IBOutlet weak var dataText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    
    private var _data : Issues?
    var data : Issues?{
        get{
            return _data
        }
        set(newVal){
            _data = newVal
            guard let data = newVal else{
                return
            }
            dataText.text = data.title!
            let repo = data.repository!
            let user = data.user!
            let number = data.number!
            let updated_date = data.updated_at!
            
            let repoName = repo.name!
            let userName = user.login!
            
            let infoText = repoName + " #" + String(number) + " updated at " + updated_date.dateCalcul() + " by " + userName
            self.infoText.text = infoText
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ issue : Issues){
        data = issue
    }
}
