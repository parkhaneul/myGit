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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
