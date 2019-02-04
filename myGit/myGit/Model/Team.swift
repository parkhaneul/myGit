//
//  Team.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Team : CustomInfoType{
    var data : JSON = [
        "id": 0,
        "node_id": "",
        "url": "",
        "name": "",
        "slug": "",
        "description": "",
        "privacy": "",
        "permission": "",
        "members_url": "",
        "repositories_url": "",
        "parent": Team([:])
    ]
    
    init(_ json : JSON){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if key == "parent" && !(value is NSNull) {
                    data[key] = Team(value as! JSON)
                } else{
                    data[key] = value
                }
            } else{
                print("Team data [" + key + "] is not mapping")
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
