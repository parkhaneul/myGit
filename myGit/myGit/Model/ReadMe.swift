//
//  ReadMe.swift
//  myGit
//
//  Created by 박하늘 on 23/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct links : CustomInfoType{
    var data : JSON = [
        "git": "",
        "self": "",
        "html": ""
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                data[key] = value
            } else{
                print("link data [" + key + "] is not mapping")
            }
        }
    }
}

struct ReadMe : CustomInfoType{
    var data : JSON = [
        "type": "",
        "encoding": "",
        "size": 0,
        "name": "README.md",
        "path": "README.md",
        "content": "",
        "sha": "",
        "url": "",
        "git_url": "",
        "html_url": "",
        "download_url": "",
        "_links": links([:])
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                if(key == "_links"){
                    data[key] = links(value as! JSON)
                } else{
                    data[key] = value
                }
            } else{
                print("ReadMe data [" + key + "] is not mapping")
            }
        }
    }
}
