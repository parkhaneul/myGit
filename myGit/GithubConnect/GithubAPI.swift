//
//  GithubAPI.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation
import RxSwift

var shared_authentication : Authentication?

struct GithubAPI{
    static let API = GithubAPI()
    
    let disposebag = DisposeBag()
    
    private init(){
    }
    
    public func createNewAuth(basicAuth : BasicAuthentication) -> Observable<Authorizations>{
        let api = Github.api(authentication: basicAuth)
        return api.post(path: "/authorizations", parameters: ["note" : login.authNote.rawValue]).map{
            return self.toModel($0)!
        }
    }
    
    public func getAuth(basicAuth : BasicAuthentication) -> Observable<[Authorizations]>{
        let api = Github.api(authentication: basicAuth)
        return api.get(path: "/authorizations").map{
            return self.toModelArray($0) ?? []
        }
    }
    
    public func getUserByToken() -> Observable<Owner>{
        return Github.api().get(path: "/user").map{
            return self.toModel($0)!
        }
    }
    
    public func getIssueByToken() -> Observable<[Issues]>{
        return Github.api().get(path: "/user/issues",parameters:["filter":"all", "sort":"update"]).map{
            return self.toModelArray($0) ?? []
        }
    }
    
    public func getClosedIssueByToken() -> Observable<[Issues]>{
        return Github.api().get(path: "/user/issues",parameters:["filter":"all", "sort":"update","state":"closed"]).map{
            return self.toModelArray($0) ?? []
        }
    }
    
    public func getIssueCommentsByRepoAndNumber(info : (String,String,Int)) -> Observable<[Comment]>{
        return Github.api().get(path: "/repos/\(info.0)/\(info.1)/issues/\(info.2)/comments").map{
            return self.toModelArray($0) ?? []
        }
    }
    
    public func getUserReposByToken() -> Observable<[Repository]>{
        return Github.api().get(path: "/user/repos", parameters:["sort":"updated"]).map{
            return self.toModelArray($0) ?? []
        }
    }
    
    public func getUserStarred() -> Observable<[Repository]>{
        return Github.api().get(path: "/user/starred", parameters:["sort":"updated"]).map{
            return self.toModelArray($0) ?? []
        }
    }
    
    public func getDataFromString(URLString : String) -> Observable<Data>{
        return Github.api().get(full_path: URLString)
    }
    
    public func getContentsByPath(path : String) -> Observable<[Contents]>{
        return Github.api().get(path: "/repos/" + path).map{
            return self.toModelArray($0) ?? []
        }
    }
    
    public func getFileByPath(path : String) -> Observable<Contents>{
        return Github.api().get(path: "/repos/" + path).map{
            return self.toModel($0)!
        }
    }
    
    public func getFollowing() -> Observable<[Owner]>{
        return Github.api().get(path : "/user/following").map{
            return self.toModelArray($0) ?? []
        }

    }
    
    public func getFollowers() -> Observable<[Owner]>{
        return Github.api().get(path : "/user/followers").map{
            return self.toModelArray($0) ?? []
        }
    }
    
    public func getUserByLoginString(_ login : String) -> Observable<Owner>{
        return Github.api().get(path: "/users/\(login)").map{
            return self.toModel($0)!
        }
    }
    
    public func getReadMe(full_path url: String) -> Observable<Contents>{
        return Github.api().get(full_path: url).map{
            return self.toModel($0)!

        }
    }
    
    func toModel<E : Codable>(_ json : Data) -> E?{
        return try? JSONDecoder().decode(E.self, from: json)
    }
    
    func toModelArray<E : Codable>(_ json : Data) -> [E]?{
        return try? JSONDecoder().decode([E].self, from: json)
    }
}
