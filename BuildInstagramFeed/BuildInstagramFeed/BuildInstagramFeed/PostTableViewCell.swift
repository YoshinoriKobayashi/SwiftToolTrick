//
//  PostTableViewCell.swift
//  BuildInstagramFeed
//
//  Created by yoshiiikoba on 2020/09/25.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    
    static let identifier = "PostTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PostTableViewCell", bundle: nil)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: InstagramPost) {
        self.likesLabel.text = "\(model.numberOfLikes) Likes"
        self.userNameLabel.text = model.userName
        self.userImageView.image = UIImage(named: model.userImageName)
        self.postImageView.image = UIImage(named: model.postImageName)
    }
    
}
