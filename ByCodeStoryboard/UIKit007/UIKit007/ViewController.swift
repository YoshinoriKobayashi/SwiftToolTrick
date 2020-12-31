//
//  ViewController.swift
//  UIKit007
//
//  Created by yoshiiikoba on 2020/09/22.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 小さめのフォントの文字列をラベルに表示する
        let mySmallLabel: UILabel  = UILabel(frame: CGRect(x:25, y:0,width: 300,height: 150))
        mySmallLabel.text = "小さめのフォント"
        mySmallLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        self.view.addSubview(mySmallLabel)
        
    }


}

