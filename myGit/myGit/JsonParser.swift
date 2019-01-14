//
//  JsonParser.swift
//  myGit
//
//  Created by 박하늘 on 14/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

class JsonParser{
    func jsonDescription(json : [String : Any]){
        print("{")
        for line in json{
            print("\t" + line.key + " : " + (line.value as? String ?? (line.value as AnyObject).description))
        }
        print("}")
    }
}
