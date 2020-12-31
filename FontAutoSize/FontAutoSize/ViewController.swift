//
//  ViewController.swift
//  FontAutoSize
//
//  Created by yoshiiikoba on 2020/08/28.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // フォントサイズを縮小して、タイトル文字列をラベルの外接矩形に収めるかどうかを示す論理値。
        // 縮小するので、フォントは最大値にしておく。
        AutoLabel.adjustsFontSizeToFitWidth = true
    }
    
    @IBOutlet weak var AutoLabel: UILabel!
    
    
}

