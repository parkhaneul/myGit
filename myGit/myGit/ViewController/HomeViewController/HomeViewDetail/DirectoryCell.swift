//
//  DirectoryCell.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class DirectoryCell : UITableViewCell{
    var path : String = ""
    
    @IBOutlet weak var contentsName: UILabel!
    
    func setPath(_ path : String){
        self.path = path
    }
    
    func setData(_ data : Contents){
        contentsName.text = data.get("name") as! String
    }
}
