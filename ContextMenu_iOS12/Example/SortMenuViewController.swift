//
//  SortMenuViewController.swift
//  Example
//
//  Created by kobayashi on 2022/03/14.
//  Copyright © 2022 Ryan Nystrom. All rights reserved.
//

import UIKit

// UIViewControllerになると、一画面のメニューになる
// UITableViewになると、テーブル（リスト）形式のメニューになる
class SortMenuViewController: UIViewController{

    let rows = 2
    
    let sortMenu =  ["売れ筋順" ,"高評価順"]

    let uiView = UIView()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = ""

        let menuHeight = 88
        let menuWidth = 250
        
        preferredContentSize = CGSize(width: menuWidth, height: menuHeight)
        
        for i in 0 ..< sortMenu.count {
            let button = UIButton()
            button.setTitle(" " + sortMenu[i], for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 7.0)
            button.setTitleColor(.black, for: .normal)
            button.contentHorizontalAlignment = .left
            button.frame = CGRect(x:0, y:menuHeight / 2 * i, width:menuWidth, height: menuHeight / 2)
            button.addTarget(self, action: #selector(self.tap), for: .touchUpInside)
            button.tag = i
            self.view.addSubview(button)
        }
        

//        view.addSubview(uiView)
//        uiView.backgroundColor = UIColor.blue

        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.reloadData()
//        tableView.layoutIfNeeded()
//        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
////        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
//        tableView.backgroundColor = .clear
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        uiView.frame = view.bounds
    }
    
    
    @objc func tap(_ sender:UIButton) {
            print("\(sender.tag)番目がタップされた")
            sender.isSelected = !sender.isSelected
        }

    @objc func onDone() {
        dismiss(animated: true)
    }

    @objc func onDismiss() {
        uiView.resignFirstResponder()
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
