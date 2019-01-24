//
//  MileStone.swift
//  myGit
//
//  Created by 박하늘 on 22/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct MileStone : CustomInfoType{
    var data : JSON = [
        "url": "",
        "html_url": "",
        "labels_url": "",
        "id": 0,
        "node_id": "",
        "number": 0,
        "state": "",
        "title": "",
        "description": "",
        "creator": Owner([:]),
        "open_issues": 0,
        "closed_issues": 0,
        "created_at": "",
        "updated_at": "",
        "closed_at": "",
        "due_on": ""
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if(key == "creator"){
                    data[key] = Owner(value as! JSON)
                }
                data[key] = value
            } else{
                print("MileStone data [" + key + "] is not mapping")
            }
        }
    }
}
