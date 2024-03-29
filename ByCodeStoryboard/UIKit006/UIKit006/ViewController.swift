//
//  ViewController.swift
//  UIKit006
//
//  Created by yoshiiikoba on 2020/09/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    // Tableで使用する配列を設定する
    private let myItems: NSArray = ["TEST1","TEST2","TEST3"]
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Status Barの高さを取得する
        // シングルトンアプリインスタンス
        // statusBarFrame はiOS14以降は非推奨
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する
        let displayWidth : CGFloat = self.view.frame.width
        let displayHeight : CGFloat = self.view.frame.height
        
        // TableViewの生成（Status barの高さをずらして表示）
        myTableView = UITableView(frame: CGRect(x:0, y:barHeight, width:displayWidth, height: displayHeight))
        
        // Cell名の登録を行う
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceを自信に設定する
        myTableView.dataSource = self
        
        // Delegateを自信に設定する
        myTableView.delegate = self
        
        // Viewに追加する
        self.view.addSubview(myTableView)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Cellが選択された際に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num \(indexPath.row)")
        print("Value \(myItems[indexPath.row])")        
    }
    
    // Cellの総数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }

    // Cellに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する。
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // Cellに値を設定する
        cell.textLabel!.text = "\(myItems[indexPath.row])"
        
        return cell
    }
}

