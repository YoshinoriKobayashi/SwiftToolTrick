//
//  ViewController.swift
//  SwiftDelegate
//
//  Created by yoshiiikoba on 2020/09/11.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         
        let person = Person() // 処理を任せるクラス
//        let john = John() // 処理を任されるクラス
//        
//        person.delegate = john  // 処理を任せる相手を指定する。

        let jack = Jack() // 処理を任されるクラス        
        person.delegate = jack  // 処理を任せる相手を指定する。
        
        person.greet()

    }


}

