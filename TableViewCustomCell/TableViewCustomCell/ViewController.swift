//
//  ViewController.swift
//  TableViewCustomCell
//
//  Created by yoshiiikoba on 2020/09/03.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stationList.dataSource = self
        stationList.delegate = self
        
        // カスタムセルを使う
        // 新しいテーブルセルの作成に使用するクラスを登録します。
        // cellClass:テーブルで使用するセルのクラス（サブクラスである必要があります）。UITableViewCell
        // identifier:セルの再利用識別子。このパラメーターはnil空の文字列であってはならず、また空の文字列であってはなりません。
        stationList.register(UINib(nibName: "StationTableViewCell", bundle: nil), forCellReuseIdentifier: "StationTableViewCell")
        self.setupStations()
    }

    @IBOutlet weak var stationList: UITableView!
    var stations:[Station] = [Station]()
    
    func setupStations() {
        stations = [Station(name: "桜新町", prefecture: "東京都世田谷区"), Station(name: "渋谷", prefecture: "東京都渋谷区"), Station(name: "目黒", prefecture: "東京都目黒区") ];
    }
    
    // セッションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セルの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    // セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         // 識別子で特定される再利用可能なテーブルビューセルオブジェクトを返します。
        // identifier:再利用するセルオブジェクトを識別する文字列。このパラメータをにすることはできませんnil。

        // カスタムセル
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell", for: indexPath) as! StationTableViewCell
        
        // カスタムセルへセット
        cell.setCell(station: stations[indexPath.row])
        
        return cell
     }
    
}

