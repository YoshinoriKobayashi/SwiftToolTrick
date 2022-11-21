//
//  ViewController.swift
//  TextHighlight2
//
//  Created by Yoshinori Kobayashi on 2022/11/17.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

class Label: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.text = "That's right by the way {filter:the woerd silver} has a {ignore:special meaning} in {filter:japon}. Can you {ignore:guess} what it is?"
        self.font = UIFont.boldSystemFont(ofSize: 14)
        // UILabelはlayoutManagerがない
    }
    
}

class TextView: UITextView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.text = "That's right by the way {filter:the woerd silver} has a {ignore:special meaning} in {filter:japon}. Can you {ignore:guess} what it is?"
        self.font = UIFont.boldSystemFont(ofSize: 14)
        self.textColor = UIColor.green
        let aaa = setAttribute(uiView: self)
        print(aaa)
        
    }
    
}

// UILabelではダメ、UITextViewでないとlayoutManagerのプロパティが使えない
// iOS15とiOS16で検証すること！！
func setAttribute(uiView: UITextView) -> Bool{
    
    // {filter:...}、{ignore:...}がヒットする正規表現
    // let pattern = "\\{.*?:.*?\\}"
    
    
    // {filter:...}
    // ??? に置換
    // 背景をグレー
    //
    
    var pattern = "\\{filter:.*?\\}"
    var regex = try! NSRegularExpression(pattern: pattern)
    // 置換後の文字を設定
    uiView.text = uiView.text.replacingOccurrences(of: pattern, with: " ??? ",  options: .regularExpression, range: nil)
        
    // {ignore:...}
    // イタリックにする
    // {ignore:...}を文字に置換する、もしくは除く
    pattern = "\\{ignore:.*?\\}"
    regex = try! NSRegularExpression(pattern: pattern)
    var matches = regex.matches(in: uiView.text, range: NSRange(0..<uiView.text.count))
    
    // 斜体にする
    for index in matches.indices {
        let attributeString = NSMutableAttributedString(attributedString: uiView.attributedText)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Avenir-BookOblique", size: 14.0)!
        ]
        attributeString.addAttributes(attributes,range: matches[index].range)
        uiView.attributedText = attributeString   
    }
    // 置換
    pattern = "\\{ignore:"
    regex = try! NSRegularExpression(pattern: pattern)
    // ヒットしなくなるまで削除を繰り返す
    while true {
        let firstRange = regex.rangeOfFirstMatch(in: uiView.text, range: NSRange(0..<uiView.text.count))
        
        // ヒットしなくなる
        if firstRange.location == NSNotFound {
            break
        }
        let attributeString = NSMutableAttributedString(attributedString: uiView.attributedText)
        // 文字の削除
        attributeString.deleteCharacters(in: firstRange)
        uiView.attributedText = attributeString   
    }
    pattern = "\\}"
    regex = try! NSRegularExpression(pattern: pattern)
    // ヒットしなくなるまで削除を繰り返す
    while true {
        // パターンにヒットした最初の1件の範囲を取得
        let firstRange = regex.rangeOfFirstMatch(in: uiView.text, range: NSRange(0..<uiView.text.count))
        // ヒットしなくなる
        if firstRange.location == NSNotFound {
            break
        }
        let attributeString = NSMutableAttributedString(attributedString: uiView.attributedText)
        // 文字の削除
        attributeString.deleteCharacters(in: firstRange)
        uiView.attributedText = attributeString           
    }
    
    
    // ??? を検索して、背景を塗る
    // 角丸背景は文字位置からViewを描くので、文字数が確定した一番最後に処理をする。
    pattern = #"\?{3}"#
    regex = try! NSRegularExpression(pattern: pattern)
    matches = regex.matches(in: uiView.text, range: NSRange(0..<uiView.text.count))
    // rangeで文字列の位置を探せる
    //    let range = (uiView.text as NSString).range(of: "ignore")
    // 与えられたコンテナ内にある、与えられた glyphRange 内のグリフを完全に囲む最小の外接矩形を返します。
    // 範囲は、外接矩形を計算する前に、コンテナの範囲と交差されます。
    // このメソッドは、グリフ範囲を無効化するための表示矩形に変換するために用いることができます。 
    // 外接矩形は常にコンテナ座標になります。
    
    for index in matches.indices {
        var rect = uiView.layoutManager.boundingRect(forGlyphRange: matches[index].range, in: uiView.textContainer)
        
        rect.origin.x += uiView.textContainerInset.left
        rect.origin.y += uiView.textContainerInset.top
        
        let tagNo = 300 + index
        // viewWithTag：tagの番号からviewを呼び出し
        // 前回の描画を削除している
        uiView.viewWithTag(tagNo)?.removeFromSuperview()
        
        let view = UIView()
        view.backgroundColor = .lightGray
        view.frame = CGRect(x: rect.minX - 5, y: rect.minY - 2, width: rect.width + 10, height: rect.height + 4)
        // アプリケーションでビューオブジェクトを識別するために使用できる整数値です。
        // あとでViewを消すために、tagを設置
        view.tag = tagNo
        // 角丸
        view.layer.cornerRadius = 5
        
        uiView.addSubview(view)
        uiView.sendSubviewToBack(view)
        
        // 文字を黒にする
        // すでにattributeが設定されているのを考慮して、NSMutableAttributedStringを作成する
        let attributeString = NSMutableAttributedString(attributedString: uiView.attributedText)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        attributeString.addAttributes(attributes,range: matches[index].range)
        uiView.attributedText = attributeString
    }
    
    
    return true
    
}

