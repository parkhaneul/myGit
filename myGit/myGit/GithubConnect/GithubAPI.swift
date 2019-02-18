//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

var shared_authentication : Authentication?

struct GithubAPI{
    public func createNewAuth(basicAuth : BasicAuthentication, completion : @escaping (Authorizations?) -> ()){
        let api = Github(authentication: basicAuth)
        var returnValue : Authorizations?
        api.post(path: "/authorizations", parameters: ["note" : login.authNote.rawValue]) { (response, error) in
            if let response = response{
                returnValue = self.toModel(response)
                completion(returnValue)
            }
        }
    }
    
    public func getAuth(basicAuth : BasicAuthentication, completion : @escaping(Authorizations?) -> ()){
        let loginGit = Github(authentication: basicAuth)
        var returnValue : Authorizations?
        loginGit.get(path: "/authorizations"){(response,error) in
            if let response = response{
                let authList : [Authorizations]? = self.toModelArray(response)
                if let authList = authList{
                    for auth in authList{
                        if auth.note == login.authNote.rawValue{
                            returnValue = auth
                        }
                    }
                    completion(returnValue)
                }
            }
        }
    }
    
    public func getUserByToken(completion : @escaping(Owner?) -> ()){
        var returnValue : Owner?
        Github().get(path: "/user"){(response, error) in
            if let response = response{
                returnValue = self.toModel(response)
            }
            completion(returnValue)
        }
    }
    
    public func getIssueByToken(completion : @escaping([Issues]?) -> ()){
        var returnValue : [Issues]?
        Github().get(path: "/user/issues",parameters:["filter":"all", "sort":"update"]){(response,error) in
            if let response = response{
                returnValue = self.toModelArray(response)
            }
            completion(returnValue)
        }
    }
    
    public func getClosedIssueByToken(completion : @escaping([Issues]?) -> ()){
        var returnValue : [Issues]?
        Github().get(path: "/user/issues",parameters:["filter":"all", "sort":"update","state":"closed"]){(response,error) in
            if let response = response{
                returnValue = self.toModelArray(response)
            }
            completion(returnValue)
        }
    }
    
    public func getIssueCommentsByRepoAndNumber(info : (String,String,Int), completion : @escaping([Comment]?) -> ()){
        var returnValue : [Comment]?
        Github().get(path: "/repos/\(info.0)/\(info.1)/issues/\(info.2)/comments"){(response,error) in
            if let response = response{
                returnValue = self.toModelArray(response)
            }
            completion(returnValue)
        }
    }
    
    public func getUserReposByToken(completion : @escaping([Repository]?) -> ()){
        var returnValue : [Repository]?
        Github().get(path: "/user/repos", parameters:["sort":"updated"]){(response,error) in
            if let response = response{
                returnValue = self.toModelArray(response)
            }
            completion(returnValue)
        }
    }
    
    public func getUserStarred(completion : @escaping([Repository]?) -> ()){
        var returnValue : [Repository]?
        Github().get(path: "/user/starred", parameters:["sort":"updated"]){(response,error) in
            if let response = response{
                returnValue = self.toModelArray(response)
            }
            completion(returnValue)
        }
    }
    
    public func getDataFromString(URLString : String, completion : @escaping(Data?, Error?) -> Void){
        Github().get(full_path: URLString, completion: completion)
    }
    
    public func getContentsByPath(path : String, completion : @escaping([Contents]?) -> ()){
        var returnValue : [Contents]?
        Github().get(path: "/repos/" + path){(response,error) in
            if let response = response{
                returnValue = self.toModelArray(response)
                returnValue?.sort(by: { $1.type! > $0.type! })
            }
            completion(returnValue)
        }
    }
    
    public func getFileByPath(path : String, completion : @escaping(Contents?) -> ()){
        var returnValue : Contents?
        Github().get(path: "/repos/" + path){(response,error) in
            if let response = response{
                returnValue = self.toModel(response)
            }
            completion(returnValue)
        }
    }
    
    public func getFollowing(completion : @escaping([Owner]?) ->()){
        var returnValue : [Owner]?
        Github().get(path : "/user/following"){(response, error) in
            if let response = response{
                returnValue = self.toModelArray(response)
            }
            completion(returnValue)
        }
    }
    
    public func getFollowers(completion : @escaping([Owner]?) ->()){
        var returnValue : [Owner]?
        Github().get(path : "/user/followers"){(response, error) in
            if let response = response{
                returnValue = self.toModelArray(response)
            }
            completion(returnValue)
        }
    }
    
    public func getUserByLoginString(_ login : String, completion : @escaping(Owner?) -> ()){
        var returnValue : Owner?
        Github().get(path: "/users/\(login)"){(response,error) in
            if let response = response{
                returnValue = self.toModel(response)
            }
            completion(returnValue)
        }
    }
    
    public func getReadMe(full_path url: String, completion : @escaping(Contents?) -> ()){
        var returnValue : Contents?
        Github().get(full_path: url, completion: {(response, error) in
            if let response = response{
                returnValue = self.toModel(response)
            }
            completion(returnValue)
        })
    }
    
    func toModel<E : Codable>(_ json : Data) -> E?{
        return try? JSONDecoder().decode(E.self, from: json)
    }
    
    func toModelArray<E : Codable>(_ json : Data) -> [E]?{
        return try? JSONDecoder().decode([E].self, from: json)
    }
}
