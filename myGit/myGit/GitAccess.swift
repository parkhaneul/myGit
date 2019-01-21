//
//  GitAccess.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

public struct GitAccess{
    var authentication : Authentication?
    let baseURL = "http://api.github.com"
    
    init(authentication : Authentication? = nil){
        self.authentication = authentication
    }
    
    func addAuthenticationIfNeeded(_ headers: [String : String]?, parameters: [String : String]?) -> (headers: [String : String]?, parameters: [String : String]?) {
        var newHeaders = headers
        var newParameters = parameters
        if let authentication = self.authentication {
            if authentication.type == .headers {
                if var newHeaders = newHeaders {
                    newHeaders[authentication.key] = authentication.value
                    return (newHeaders, newParameters)
                } else {
                    newHeaders = [String : String]()
                    newHeaders![authentication.key] = authentication.value
                    return (newHeaders, newParameters)
                }
            } else if authentication.type == .parameters ) {
                if var newParameters = newParameters {
                    newParameters[authentication.key] = authentication.value
                    return (newHeaders, newParameters)
                } else {
                    newParameters = [String : String]()
                    newParameters![authentication.key] = authentication.value
                    return (newHeaders, newParameters)
                }
            }
        }
        return (newHeaders, newParameters)
    }
}
