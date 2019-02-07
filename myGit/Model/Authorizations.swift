//
//  Auth.swift
//  myGit
//
//  Created by 박하늘 on 05/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Authorizations : CustomInfoType{
    var data : JSON = [
        "id": 0,
        "url": "",
        "scopes": [""],
        "token": "",
        "token_last_eight": "",
        "hashed_token": "",
        "app": AppType([:]),
        "note": "",
        "note_url": "",
        "updated_at": "",
        "created_at": "",
        "fingerprint": ""
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key) && !(value is NSNull){
                if key == "app"{
                    data[key] = AppType(value as! JSON)
                } else{
                    data[key] = value
                }
            } else{
                print("Auth data [" + key + "] is not mapping")
            }
        }
    }
    
    func get(_ key: String) -> Any? {
        if data.keys.contains(key) && !(data[key] is NSNull){
            return data[key]
        }
        
        return nil
    }
}
