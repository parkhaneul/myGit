//
//  GithubData.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

protocol CustomInfoType {
    init(json : Dictionary<String,Any>)
}

struct Owner : CustomInfoType{
    var data : Dictionary<String,Any> = [
        "login" : "",
        "id" : 0,
        "node_id" : "",
        "avatar_url" : "",
        "gravatar_url" : "",
        "gravatar_id" : "",
        "url" : "",
        "html_url" : "",
        "followers_url" : "",
        "following_url" : "",
        "gists_url" : "",
        "starred_url" : "",
        "subscriptions_url" : "",
        "organizations_url" : "",
        "repos_url" : "",
        "events_url" : "",
        "received_events_url" : "",
        "type" : "",
        "site_admin" : false
    ]
    init(json : Dictionary<String,Any>){
        let json = json
        for (key,value) in json{
            if data.keys.contains(key){
                data[key] = value
            } else{
                print("Owner data [" + key + "] is not mapping")
            }
        }
    }
}
