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
    private let sampleView = SampleView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Viewを表示する
        view.addSubview(sampleView)
        // snpでAutoLayoutを設定
        sampleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }


}

