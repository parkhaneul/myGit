//
//  Plan.swift
//  myGit
//
//  Created by 박하늘 on 12/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Plan : CustomInfoType{
    var data : JSON = [
        "name": "",
        "space": 0,
        "private_repos": 0
    ]
    
    init(_ json : JSON){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key) && !(value is NSNull){
                data[key] = value
            } else{
                print("Plan data [" + key + "] is not mapping")
            }
        }
    }
    
    func get(_ key : String) -> Any?{
        if data.keys.contains(key) && !(data[key] is NSNull){
            return data[key]
        }
        
        return nil
    }
}
