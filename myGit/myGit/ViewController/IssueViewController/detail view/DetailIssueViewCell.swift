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
    
    private var _data : Comment?
    var data : Comment?{
        get{
            return _data
        }
        set(newVal){
            _data = newVal
            guard let data = newVal else{
                return
            }
            
            let user = data.user!
            usernameText.text = user.login!
            commentDate.text = "comments at " + (data.created_at!).splitToOffset(offsetBy: 10)
            commentText.text = data.body!
            commentText.preferredMaxLayoutWidth = scroll.bounds.width
            scroll.contentSize = commentText.intrinsicContentSize
        }
    }
    var yOffset : CGFloat = 0
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(comments : Comment){
        self.data = comments
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
