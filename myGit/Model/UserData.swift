//
//  UserData.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

public class UserData{
    static let Instance : UserData = UserData()
    private var list : [String:UserResponse] = [:]
    
    init(){
    }

    public func getData(userName : String?) -> UserResponse?{
        guard let name = userName else {
            return nil
        }
        return list[name]
    }
    
    public func setData(key : String?, value : UserResponse, completion : @escaping ()->()){
        guard let key = key else{
            return
        }
        self.list[key] = value
        DispatchQueue.main.async {
            completion()
        }
    }
}
