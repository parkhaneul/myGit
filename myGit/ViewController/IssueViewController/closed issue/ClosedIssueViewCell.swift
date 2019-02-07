//
//  ClosedIssueViewCell.swift
//  myGit
//
//  Created by 박하늘 on 26/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class ClosedIssueViewCustomCell : UITableViewCell{
    @IBOutlet weak var dataText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    
    var data : Issues = Issues([:])
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ issue : Issues){
        data = issue
        dataText.text = data.get("title") as! String
        let repo = data.get("repository") as! JSON
        let repoName = repo["name"] as! String
        let number = data.get("number") as! Int
        let created_date = data.get("closed_at") as! String
        let dateString = created_date.splitToOffset(offsetBy: 10)
        let user = data.get("user") as! JSON
        let userName = user["login"] as! String
        
        let infoText = repoName + " #" + String(number) + " closed at " + dateString + " by " + userName
        self.infoText.text = infoText
    }
}
