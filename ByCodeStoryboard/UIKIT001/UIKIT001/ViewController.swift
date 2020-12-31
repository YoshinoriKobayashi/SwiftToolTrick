//
//  ViewController.swift
//  UIKIT001
//
//  Created by yoshiiikoba on 2020/08/08.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ボタンのサイズを定義
        let bWidth: CGFloat = 300
        let bHeight: CGFloat = 100
        
        // 配置する座標を定義（画面の中心）
        let posX: CGFloat = self.view.bounds.width / 2 - bWidth / 2
        let posY: CGFloat = self.view.bounds.height / 2 - bHeight / 2
        
        // Labelを作成
        let label: UILabel = UILabel(frame: CGRect(x:posX, y:posY, width: bWidth, height: bHeight))
        
        // UILabelの背景をオレンジ色に
        label.backgroundColor = UIColor.purple
        
        // UILabelの枠を丸くする
        label.layer.masksToBounds = true
        
        // 丸くするコーナーの半径
        label.layer.cornerRadius = 10.0
        
        // 文字の色を白に定義
        label.textColor = UIColor.white
        
        // UILabelに文字を代入
        label.text = "The World!"
        
        // 文字の影をグレーに定義
        label.shadowColor = UIColor.gray
        
        // Textを中央寄せにする
        label.textAlignment = NSTextAlignment.center
        
        // Viewの背景を青にする
        self.view.backgroundColor = UIColor.orange
        
        // ViewにLabelを追加
        self.view.addSubview(label)
        
    }
    
    override func didReceiveMemoryWarning() {
        super .didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

