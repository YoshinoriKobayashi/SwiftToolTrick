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
        let point = tapGesture.location(in: textView)
        if let detectedWord = getWordAtPosition(point) {
            print(detectedWord)
        }
    }
    
    // ポイントから単語を得る
    private final func getWordAtPosition(_ point: CGPoint) -> String?{
        if let textPosition = textView.closestPosition(to: point)
        {
            if let range = textView.tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection(rawValue: 1))
            {
                return textView.text(in: range)
            }
        }
        return nil
    }
}

