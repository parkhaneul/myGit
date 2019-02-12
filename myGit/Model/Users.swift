//
//  users.swift
//  myGit
//
//  Created by 박하늘 on 21/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct Users : CustomInfoType{
    var data : JSON = [
        "login": "",
        "id": 0,
        "node_id": "",
        "avatar_url": "",
        "gravatar_id": "",
        "url": "",
        "html_url": "",
        "followers_url": "",
        "following_url": "",
        "gists_url": "",
        "starred_url": "",
        "subscriptions_url": "",
        "organizations_url": "",
        "repos_url": "",
        "events_url": "",
        "received_events_url": "",
        "type": "",
        "site_admin": false,
        "name": "",
        "company": "",
        "blog": "",
        "location": "",
        "email": "",
        "hireable": "",
        "bio": "",
        "public_repos": 0,
        "public_gists": 0,
        "followers": 0,
        "following": 0,
        "created_at": "",
        "updated_at": ""
    ]
    
    init(_ json: JSON) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                data[key] = value
            } else{
                print("Users data [" + key + "] is not mapping")
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
