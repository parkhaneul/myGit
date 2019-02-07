//
//  ContentsCell.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class FileCell : UITableViewCell{
    var path : String = ""
    @IBOutlet weak var contentsName: UILabel!
    @IBOutlet weak var volume: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPath(_ path : String){
        self.path = path
    }
    
    func setData(_ data : Contents){
        contentsName.text = data.get("name") as! String
        volume.text = String(data.get("size") as! Int) + " kb"
    }
}
