//
//  DetailIssueViewCell.swift
//  myGit
//
//  Created by 박하늘 on 30/01/2019.
//  Copyright © 2019 haneulPark. All rights reserved.
//

import UIKit

class DetailIssueViewCell : UITableViewCell{
    
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    var yOffset : CGFloat = 0
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func draw(){
        commentText.preferredMaxLayoutWidth = scroll.bounds.width
        scroll.contentSize = commentText.intrinsicContentSize
    }
    
    func autoScroll(){
        var timer = 1.0
        if commentText.bounds.height > scroll.bounds.height{
            yOffset = commentText.bounds.height - scroll.bounds.height
            timer = Double(yOffset/20)
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: timer){
                self.scroll.contentOffset.y = self.yOffset
            }
        }
    }
    
    func deSelected(){
        yOffset = 0
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2){
                self.scroll.contentOffset.y = self.yOffset
            }
        }
    }
}
