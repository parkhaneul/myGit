//
//  ImageCache.swift
//  myGit
//
//  Created by 박하늘 on 04/02/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

var imageCashe = ImageCashe()
struct ImageCashe{
    private var imageList : [(String,UIImage)] = []
    private let maxCapacity = 30
    
    func isList(_ url : String) -> Bool{
        let url = url
        for image in imageList{
            if(image.0 == url){ return true }
        }
        return false
    }
    
    func getImage(_ url : String) -> UIImage?{
        let url = url
        for image in imageList{
            if(image.0 == url){ return image.1 }
        }
        return nil
    }
    
    mutating func registerImage(url : String, image : UIImage) -> UIImage{
        let url = url
        if let image = getImage(url){
            return image
        } else{
            let casheTuple = (url,image)
            if(imageList.count <= maxCapacity){
            }else{
                imageList.removeFirst()
            }
            imageList.append(casheTuple)
            return casheTuple.1
        }
    }
}
