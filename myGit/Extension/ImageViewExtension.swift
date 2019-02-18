//
//  ImageViewExtension.swift
//  myGit
//
//  Created by 박하늘 on 16/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

//download image with cashe
extension UIImageView{
    private func downloaded(urlStr str : String,from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url, completionHandler: {(data,response,error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {return}
            DispatchQueue.main.async() {
                self.image = imageCashe.registerImage(url: str, image: image)
            }
        }).resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit){
        if let img = imageCashe.getImage(link){
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

