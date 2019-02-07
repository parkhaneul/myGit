//
//  AccessTokenAuthentication.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct AccessTokenAuthentication : Authentication{
    var type: AuthenticationType{
        return .parameters
    }
    
    var key: String{
        return "access_token"
    }
    var value: String{
        return access_token
    }
    
    var access_token : String
    
    public init(access_token : String){
        self.access_token = access_token
    }
    
    func header() -> [String : String] {
        return [key : value]
    }
}
