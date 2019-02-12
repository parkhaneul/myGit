//
//  File.swift
//  myGit
//
//  Created by 박하늘 on 15/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

// 1. KVC - Swift
// 2. KVC - Swift - Struct
// 3. Object Mapper

import Foundation

public struct UserResponse{
    public init(data : Data){
        //"api.github.com/user"
        /*
        let model = try! JSONSerialization.jsonObject(with: data, options:.mutableContainers) as! [String: Any]
        for m in model{
            print(m)
        }
        */
        // model is Dictionary<String, Any>*/
        
        //"api.github.com/user/repos"
        
        let model = try! JSONSerialization.jsonObject(with: data, options:.mutableContainers) as! [[String: Any]]
        for m in model{
            for d in m{
                print(d)
            }
        }
        
        // model is [[Dictionary<String, Any>]]*/
        /*
        for m in model{
            contents[m.key] = m.value as? String
        }*/
    }
}
