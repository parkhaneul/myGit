//
//  DataExtension.swift
//  myGit
//
//  Created by 박하늘 on 28/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

extension Data{
    func decode() -> Any{
        return try! JSONSerialization.jsonObject(with: self, options: .mutableContainers)
    }
    
    func toJson() -> JSON{
        return try! JSONSerialization.jsonObject(with: self, options: .mutableContainers) as! JSON
    }
    
    func toJsonArray() -> [JSON] {
        return try! JSONSerialization.jsonObject(with: self, options: .mutableContainers) as! [JSON]
    }
}
