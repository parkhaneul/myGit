//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct GithubAPI{
    public func createNewAuth(basicAuth : BasicAuthentication, completion : @escaping(Data?, Error?) -> Void){
        let loginGit = Github(authentication: basicAuth)
        loginGit.post(path : "/authorizations",
                      parameters : ["note" : login.authNote.rawValue],
                      completion : completion)
    }
    
    public func getAuth(basicAuth : BasicAuthentication,client_id : String, completion : @escaping (Data?, Error?) -> Void){
        let loginGit = Github(authentication: basicAuth)
        loginGit.getNonAuth(full_path : "https://github.com/login/oauth/authorize",
                      parameters : ["client_id" : client_id],
                      completion : completion)
    }
    
    public func getAuth(basicAuth : BasicAuthentication, completion : @escaping(Data?, Error?) -> Void){
        let loginGit = Github(authentication: basicAuth)
        loginGit.get(path: "/authorizations",completion: completion)
    }
    
    public func putAuth(basicAuth : BasicAuthentication, client_id : String, completion : @escaping(Data?, Error?) -> Void){
        let loginGit = Github(authentication: basicAuth)
        loginGit.put(path: "/authorizations/clients/\(client_id)",
            parameters:["client_secret" : "c7a393663ba9511c9e46c66bf029071a6652cb97",
                        "note" : login.authNote.rawValue],
            completion: completion)
    }
    
    public func getUserOrg(completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/user/orgs", completion: completion)
    }
    
    public func getUserByToken(completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/user",
                completion : completion)
    }
    
    public func getIssueByToken(completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/user/issues",
                parameters:["filter":"all", "sort":"update"],
                completion : completion)
    }
    
    public func getClosedIssueByToken(completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/user/issues",
                parameters:["filter":"all", "sort":"update", "state":"closed"],
                completion : completion)
    }
    
    public func getIssueCommentsByRepoAndNumber(info : (String,String,Int), completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/repos/\(info.0)/\(info.1)/issues/\(info.2)/comments",
            completion: completion)
    }
    
    public func getUserReposByToken(completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/user/repos",
                parameters:["sort":"updated"],
                completion : completion)
    }
    
    public func getOrgFork(org : String, completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/orgs/\(org)/repos/",
            parameters : ["type" : "forks"],
            completion : completion)
    }
    
    public func getUserStarred(completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/user/starred",
                parameters:["sort":"updated"],
                completion : completion)
    }
    
    public func getDataFromString(URLString : String, completion : @escaping(Data?, Error?) -> Void){
        Github().get(full_path: URLString,
                completion: completion)
    }
    
    public func getFileByPath(path : String, completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/repos/" + path,
                completion: completion)
    }
    
    public func getFollowing(completion : @escaping(Data?, Error?) -> Void){
        Github().get(path : "/user/following", completion : completion)
    }
    
    public func getFollowers(completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/user/followers", completion: completion)
    }
    
    public func getUserByLoginString(_ login : String, completion : @escaping(Data?, Error?) -> Void){
        Github().get(path: "/users/\(login)", completion: completion)
    }
}
