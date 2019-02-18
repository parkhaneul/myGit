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
    
    func setPath(_ path : String){
        self.path = path
    }
    
    func setData(_ data : Contents){
        contentsName.text = data.name
        volume.text = String(data.size!) + " kb"
    }
}
