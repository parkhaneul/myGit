//
//  ImageViewExtension.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit
import Alamofire

//download image with cashe
extension UIImageView{
    private func downloaded(urlStr str : String,from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        AF.request(url)
        .validate(statusCode: 200..<300)
        .response{ response in
            guard
                let data = response.data,
                let image = UIImage(data : data) else{
                return
            }
            DispatchQueue.main.async {
                self.image = imageCache.registerImage(url: str, image: image)
            }
        }
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit){
        if let img = imageCache.getImage(link){
            self.image = img
        } else{
            guard let url = URL(string: link) else { return }
            downloaded(urlStr: link,from: url, contentMode: mode)
        }
    }
}

//uiimage layer
extension UIImageView{
    func circularImage(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.layer.bounds.height/2
        self.clipsToBounds = true
    }
    
    func setBorder(width : Int, color : CGColor){
        self.layer.borderColor = color
        self.layer.borderWidth = CGFloat(width)
    }
}

