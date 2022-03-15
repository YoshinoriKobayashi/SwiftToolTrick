//
//  SortMenuViewController.swift
//  Example
//
//  Created by kobayashi on 2022/03/14.
//  Copyright © 2022 Ryan Nystrom. All rights reserved.
//

import UIKit

class SortMenuViewController: UITableViewController {

    let rows = 2
    
    let sortMenu =  ["売れ筋順" ,"高評価順"]

    let coView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = ""

        preferredContentSize = CGSize(width: 300, height: 200)
        view.addSubview(coView)
        coView.backgroundColor = UIColor.blue
        coView.translatesAutoresizingMaskIntoConstraints = false

        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.reloadData()
//        tableView.layoutIfNeeded()
//        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
////        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
//        tableView.backgroundColor = .clear
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coView.frame = view.bounds
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Int(rows)
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(sortMenu[indexPath.row])"
//        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
//        cell.textLabel?.textColor = .black
//        cell.backgroundColor = .clear
////        cell.accessoryType = .disclosureIndicator
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
//        print("並び替え")
////        navigationController?.pushViewController(SortMenuViewController(), animated: true)
//    }
}
