//
//  PullRequest.swift
//  myGit
//
//  Created by 박하늘 on 22/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Pull_Request : CustomInfoType{
    var data : JSON = [
        "url": "",
        "html_url": "",
        "diff_url": "",
        "patch_url": ""
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                data[key] = value
            } else{
                print("Pull_Request data [" + key + "] is not mapping")
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
