//
//  Labels.swift
//  myGit
//
//  Created by 박하늘 on 22/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Labels : CustomInfoType{
    var data : JSON = [
        "id": 0,
        "node_id": "",
        "url": "",
        "name": "",
        "description": "",
        "color": "",
        "default": false
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                data[key] = value
            } else{
                print("Labels data [" + key + "] is not mapping")
            }
        }
    }
}
