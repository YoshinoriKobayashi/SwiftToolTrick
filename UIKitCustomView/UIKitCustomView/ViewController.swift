//
//  ViewController.swift
//  UIKitCustomView
//
//  Created by kobayashi on 2022/05/30.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // カスタムViewの使用
    private let sampleView = SampleView(productName: "明治チョコボール", categoryName: "チョコレート")

    override func viewDidLoad() {
        super.viewDidLoad()

        // 遷移先にプロパティ（変数）を設定する場合
//        sampleView.productName = "明治チョコボール"
//        sampleView.categoryName = "チョコレート"

        // 遷移先のラベルを設定する場合はこれでいい
//        sampleView.productNameLabel.text = "明治チョコボール"
//        sampleView.categoryNameLabel.text = "チョコレート"

        // Viewを表示する
        view.addSubview(sampleView)
        // snpでAutoLayoutを設定
        sampleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalToSuperview()
        }
    }


}

