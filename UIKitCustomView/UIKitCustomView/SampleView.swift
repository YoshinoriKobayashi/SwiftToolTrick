//
//  SampleView.swift
//  UIKitCustomView
//
//  Created by kobayashi on 2022/05/30.
//

import UIKit

final class SampleView: UIView {

    @IBOutlet weak var AmazonButton: UIButton!
    @IBOutlet weak var YahooButton: UIButton!
    @IBOutlet weak var RukkutenButton: UIButton!

    var productName = ""
    var categoryName = ""

    // UIViewの場合は、initで引数をもらうと画面のコントールに設定できる
    init(productName:String,categoryName:String) {
        super.init(frame: .zero)

        // Xibを使用するためのコード
        let view = UINib(nibName: "SampleView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]

        print(productName)
        print(categoryName)

        AmazonButton.setTitleColor(UIColor.red, for: .normal)
        AmazonButton.layer.borderColor = UIColor.red.cgColor
        AmazonButton.layer.borderWidth = 2

//
//        YahooButton.layer.borderColor = Color.red
//        RukkutenButton.layer.borderColor = Color.red

    }

    // 必ず必要
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // 制約の更新に関するメソッド
    // 開発者が直接呼び出すのはNG→呼び出すと落ちる
//    override func updateConstraints() {
//        print("== updateConstraints")
//    }
    // - 制約更新の実行要否のフラグを立てる 
    // - 計算実行タイミングはシステム任せ
    override func setNeedsUpdateConstraints() {
        print("== setNeedsUpdateConstraints")
    }
    // 制約更新を即座に実行（更新フラグあれば）
    override func updateConstraintsIfNeeded() {
        print("== updateConstraintsIfNeeded")
    }

    // レイアウトに関するメソッド
    // - frameの更新を実行 
    // - 開発者が直接呼び出すのはNG
    override func layoutSubviews() {
        print("== layoutSubviews")
    }
    // - frame更新要否のフラグを立てる 
    // - 計算実行タイミングはシステム任せ
    override func setNeedsLayout() {
        print("== setNeedsLayout")
    }
    // frame更新を即座に実行（更新フラグあれば）
    override func layoutIfNeeded() {
        print("== layoutIfNeeded")
    }

    // 描画に関するメソッド
    func draw() {
        print("== draw")
    }
    // - 描画更新の実行要否のフラグを立てる
    // 制約やレイアウト更新のように、 即時実行用のメソッドはなし
    override func setNeedsDisplay() {
        print("== setNeedsDisplay")
    }

}
