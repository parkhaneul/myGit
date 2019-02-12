//
//  BasicAuthentication.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

public struct BasicAuthentication : Authentication{
    var type: AuthenticationType{
        return .headers
    }
    var username : String
    var password : String
    var authrization : String{
        return username + ":" + password
    }
    
    public init(username : String, password : String){
        self.username = username
        self.password = password
    }
    
    var key: String{
        return "Authorization"
        //return username
    }
    var value: String{
        return "Basic \(authrization.toBase64() ?? "")"
    }
    
    func header() -> [String : String]{
        return [key:value]
    }
}
