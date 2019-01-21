//
//  TokenAuthentication.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct TokenAuthentication : Authentication{
    var type: AuthenticationType{
        return .headers
    }
    
    var key: String{
        return "Authorization"
    }
    var value: String{
        return "token \(self.token)"
    }
    
    var token : String
    
    public init(token : String){
        self.token = token
    }
    
    func header() -> [String : String] {
        return [key:value]
    }
}
