//
//  ArticlesListCell.swift
//  PracticalTest
//
//  Created by Shekhar Vishwakarma on 06/07/20.
//  Copyright © 2020 shekhar. All rights reserved.
//

import UIKit

class ArticlesListCell: UITableViewCell {
    
    //MARK: IBOutlet :-
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserDesignation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblArticleContent: UILabel!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var lblArticleUrl: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var imgViewArticle: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgViewUser.layer.borderWidth = 1
        imgViewUser.layer.borderColor = UIColor.darkGray.cgColor
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    func configureArticleData(objData: Blogs) {
        
        self.lblComments.text =   Utility.formatNumbers(from: Int(objData.comment ?? "0") ?? 0) + " Comments"
        self.lblLikes.text = Utility.formatNumbers(from: Int(objData.likes ?? "0") ?? 0) + " Likes"
        self.lblArticleContent.text = objData.content
        
        if let user = objData.user, user.id != nil {
            
            self.lblUserName.text = user.name
            self.lblUserDesignation.text = user.designation
            if let url = user.avatar {
                self.imgViewUser.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
            }
        }
        
        if let media = objData.media, media.id != nil {
            self.lblArticleUrl.isHidden = false
            self.lblArticleTitle.isHidden = false
            self.imgViewArticle.isHidden = false
            self.lblArticleTitle.text = media.title
            self.lblArticleUrl.text = media.url
            if let url = media.image {
                self.imgViewArticle.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
            }
            
        } else {
            self.lblArticleUrl.isHidden = true
            self.lblArticleTitle.isHidden = true
            self.imgViewArticle.isHidden = true
        }
        
    }
    
}
