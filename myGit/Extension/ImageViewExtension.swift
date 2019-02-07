//
//  ImageViewExtension.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

extension UIImageView{
    private func downloaded(name : String, from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {return}
            DispatchQueue.main.async() {
                self.image = imageCache.registerImage(name: name, image: image)
            }
        }).resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) -> UIImageView{
        if(imageCache.isList(link)){
            self.image = imageCache.getImage(link)
        }
        guard let url = URL(string: link) else { return self}
        downloaded(name : link, from: url, contentMode: mode)
        
        return self
    }
    
    func circularImage() -> UIImageView{
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.layer.bounds.height/2
        self.clipsToBounds = true
        
        return self
    }
    
    func setBorder(width : Int, color : CGColor) -> UIImageView{
        self.layer.borderColor = color
        self.layer.borderWidth = CGFloat(width)
        
        return self
    }
}

