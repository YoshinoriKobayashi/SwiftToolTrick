//
//  FeedCell.swift
//  InstaApp
//
//  Created by yoshiiikoba on 2020/10/04.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commnetLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes": likeCount + 1] as [String:Any]
            
            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)            
        }

        
    }
    
    @IBOutlet weak var documentIdLabel: UILabel!
    
    
}
