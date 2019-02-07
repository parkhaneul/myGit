//
//  Mappable.swift
//  myGit
//
//  Created by 박하늘 on 29/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import Foundation

protocol Mappable{
    func set(dictionary : JSON)
}

extension Mappable{
    func set(dictionary : JSON){
        var count = UInt32()
        guard let properties = class_copyPropertyList(self as! AnyClass, &count) else{
            return
        }
        for i in 0..<Int(count){
            guard
                let property : objc_property_t = properties[i],
                let name = NSString(utf8String: property_getName(property))
            else { continue }
            if dictionary.keys.contains(name as String) {
                
            }
        }
        free(properties)
    }
}
