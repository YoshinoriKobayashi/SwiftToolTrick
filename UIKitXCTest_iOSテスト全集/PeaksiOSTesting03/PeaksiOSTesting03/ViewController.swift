//
//  ViewController.swift
//  PeaksiOSTesting03
//
//  Created by kobayashi on 2022/04/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    static func validate(password: String) -> Bool {
        if password.count <= 7 {
            return false
        }

        // 指定されたセットの文字で分割された文字列からの部分文字列を含む配列を返します。
        //
        // 10進数のカテゴリの文字を含む文字セットを返します。
        let numString = password.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return numString.count >= 2
    }

}


