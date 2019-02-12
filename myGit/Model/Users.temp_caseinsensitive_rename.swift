//
//  users.swift
//  myGit
//
//  Created by 박하늘 on 21/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

class Users : CustomInfoType{
    var data : Dictionary<String,Any> = [
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
        "updated_at": "",
        "total_private_repos" : "",
        "private_gists" : "",
        "collaborators" : "",
        "two_factor_authentication" : "",
        "plan" : "",
        "disk_usage" : "",
        "owned_private_repos" : ""
    ]
    
    required init(json: Dictionary<String, Any>) {
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                data[key] = value
            } else{
                print("Users data [" + key + "] is not mapping")
            }
        }
    }
}
