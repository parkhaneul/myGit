//
//  ImageCache.swift
//  myGit
//
//  Created by 박하늘 on 04/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

struct ImageCahce{
    private var imageList : [(String,UIImage)] = []
    
    func isList(_ name : String) -> Bool{
        for image in imageList{
            if(image.0 == name){ return true }
        }
        return false
    }
    
    func getImage(_ name : String) -> UIImage?{
        let name = name
        for image in imageList{
            if(image.0 == name){ return image.1 }
        }
        return nil
    }
    
    mutating func registerImage(name : String, image : UIImage) -> UIImage{
        let name = name
        let image = image
        if(isList(name)){
            return getImage(name)!
        } else{
            let set = (name,image)
            imageList.append(set)
            return set.1
        }
    }
}

var imageCache = ImageCahce()
