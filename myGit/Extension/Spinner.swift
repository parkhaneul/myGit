//
//  UIViewControllerExtension.swift
//  myGit
//
//  Created by 박하늘 on 21/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class Spinner : UIView{
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        self.addSubview(self.spinner)
        self.spinner.startAnimating()
        self.spinner.center = self.center
    }
    
    init(){
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spin(onView : UIView, completion : @escaping () -> Void){
        DispatchQueue.main.async {
            onView.addSubview(self)
            self.center = onView.center
        }
        completion()
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
}
