//
//  ViewController.swift
//  UIKitTextView_tap
//
//  Created by Yoshinori Kobayashi on 2022/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textView.text = "My name is Yoshinori.I live in Tokyo.My job is programer."
        
        // タップジェスチャをUITextViewに追加
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnTextView(_:)))
        textView.addGestureRecognizer(tapGesture)
    }
    
    // タップハンドラメソッドを追加
    @objc private final func tapOnTextView(_ tapGesture: UITapGestureRecognizer) {
        
        // ジェスチャー認識器によって表現されたジェスチャーの与えられたビューにおける位置として計算された点を返します。
        // CGPoint:2次元座標系における点を含む構造体。
        let point = tapGesture.location(in: textView)
        if let detectedWord = getWordAtPosition(point) {
            print(detectedWord)
        }
    }
    
    // ポイントから単語を得る
    private final func getWordAtPosition(_ point: CGPoint) -> String?{
        
        // 指定された点に最も近い文書内の位置を返します。
        // UITextPosition:テキストコンテナ内の位置、つまりテキスト表示ビューのバックストリングへのインデックス。
        if let textPosition = textView.closestPosition(to: point){
            // rangeEnclosingPosition:指定された粒度のテキスト単位で、指定された方向のテキスト位置を囲むテキストの範囲を返す。
            // position:文書中の位置を表すtext-positionオブジェクト。
            // with:テキスト単位のある粒度を示す定数。
            // inDirection:位置に対する相対的な方向を示す定数。この定数は UITextStorageDirection または UITextLayoutDirection 型である。
            if let range = textView.tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection(rawValue: 1)){
                // ドキュメントにはないメソッド。rangeからテキストを取り出す
                return textView.text(in: range)
            }
        }
        return nil
    }
}

