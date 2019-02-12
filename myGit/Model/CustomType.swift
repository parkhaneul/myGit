//
//  CustomType.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct userInfo{
    var data : Data?
    var type : Owner?
    
    init(data : Data){
        self.data = data
        let jsonData = try! JSONSerialization.jsonObject(with: self.data!, options: .mutableContainers) as! Dictionary<String,Any>
        
        self.Owner
    }
}

extension userInfo : Codable{
    init(from decoder: Decoder) throws {
    }
    
    func encode(to encoder: Encoder) throws {
    }
}
