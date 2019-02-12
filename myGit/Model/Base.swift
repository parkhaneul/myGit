//
//  Base.swift
//  myGit
//
//  Created by 박하늘 on 25/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Base : CustomInfoType{
    var data : JSON = [
        "label": "",
        "ref": "",
        "sha": "",
        "user": Owner([:]),
        "repo": Repository([:])
    ]
    
    init(_ json : JSON){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if value is NSNull{
                    if(key == "user"){
                        data[key] = Owner(value as! JSON)
                    } else if(key == "repo"){
                        data[key] = Repository(value as! JSON)
                    }
                }else{
                    data[key] = value
                }
            } else{
                print("Base data [" + key + "] is not mapping")
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
