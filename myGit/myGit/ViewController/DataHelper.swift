//
//  DataHelper.swift
//  myGit
//
//  Created by 박하늘 on 23/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

struct DataHelper{
    private var data : JSON = [:]
    
    mutating func setData(key : String, values : Any){
        data[key] = values
    }
    
    func getData(key : String) -> Any?{
        if(data.keys.contains(key)){
            return data[key]
        }
        return nil
    }
}

var shared : DataHelper = DataHelper()
