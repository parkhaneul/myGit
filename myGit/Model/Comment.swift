//
//  Comment.swift
//  myGit
//
//  Created by 박하늘 on 28/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Comment : CustomInfoType{
    var data : JSON = [
        "url": "",
        "html_url": "",
        "issue_url": "",
        "id": 0,
        "node_id": "",
        "user": Owner([:]),
        "created_at": "",
        "updated_at": "",
        "author_association": "",
        "body": ""
    ]
    
    init(_ json : JSON){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if key == "user" && value is NSNull {
                    data[key] = Owner(value as! JSON)
                } else{
                    data[key] = value
                }
            } else{
                print("Comments data [" + key + "] is not mapping")
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
