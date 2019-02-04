//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct GithubAPI{
    let git = Github()

    public func getUserByToken(completion : @escaping(Data?, Error?) -> Void){
        git.get(path: "/user", completion : completion)
    }
    
    public func getIssueByToken(completion : @escaping(Data?, Error?) -> Void){
        git.get(path: "/user/issues",parameters:["filter":"all", "sort":"update"], completion : completion)
    }
    
    public func getClosedIssueByToken(completion : @escaping(Data?, Error?) -> Void){
        git.get(path: "/user/issues",parameters:["filter":"all", "sort":"update", "state":"closed"], completion : completion)
    }
    
    public func getIssueCommentsByRepoAndNumber(info : (String,String,Int), completion : @escaping(Data?, Error?) -> Void){
        git.get(path: "/repos/\(info.0)/\(info.1)/issues/\(info.2)/comments", completion: completion)
    }
    
    public func getUserReposByToken(completion : @escaping(Data?, Error?) -> Void){
        git.get(path: "/user/repos",parameters:["sort":"updated"], completion : completion)
    }
    
    public func getOrgFork(org : String, completion : @escaping(Data?, Error?) -> Void){
        git.get(path: "/orgs/\(org)/repos/", completion : completion)
    }
    
    public func getUserStarred(completion : @escaping(Data?, Error?) -> Void){
        git.get(path: "/user/starred",parameters:["sort":"updated"], completion : completion)
    }
    
    public func getDataFromString(URLString : String, completion : @escaping(Data?, Error?) -> Void){
        git.get(full_path: URLString, completion: completion)
    }
    
    public func getFileByPath(path : String, completion : @escaping(Data?, Error?) -> Void){
        git.get(path: "/repos/" + path, completion: completion)
    }
}
