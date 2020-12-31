//
//  ViewController.swift
//  BuildInstagramFeed
//
//  Created by yoshiiikoba on 2020/09/25.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    var models = [InstagramPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        models.append(InstagramPost(numberOfLikes: 200,
                                    userName: "zuck",
                                    userImageName: "head",
                                    postImageName: "post_1"))
        models.append(InstagramPost(numberOfLikes: 200,
                                    userName: "john",
                                    userImageName: "head",
                                    postImageName: "post_2"))
        models.append(InstagramPost(numberOfLikes: 200,
                                    userName: "jenny",
                                    userImageName: "head",
                                    postImageName: "post_3"))
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.configure(with: models[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120+140+view.frame.size.width
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

struct InstagramPost {
    let numberOfLikes: Int
    let userName: String 
    let userImageName: String
    let postImageName: String
}
