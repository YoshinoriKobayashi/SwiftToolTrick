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
        self.text = "{filter:it was} working in {ignore:hugo} {ignore:ash lee}"
        self.font = UIFont.boldSystemFont(ofSize: 20)
        // UILabelはlayoutManagerがない
    }

}

class TextView: UITextView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.text = "That's right by the way {filter:the woerd silver} has a {ignore:special meaning} in Japan. Can you {ignore:guess} what it is?"
        self.font = UIFont.boldSystemFont(ofSize: 14)
        let aaa = setAttribute(uiView: self)
        print(aaa)

    }
    
}


func setAttribute(uiView: UITextView) -> Bool{
    // {filter:...}、{ignore:...}
    let pattern = "\\{.*?:.*?\\}"

    let regex = try! NSRegularExpression(pattern: pattern)
    let matches = regex.matches(in: uiView.text, range: NSRange(0..<uiView.text.count))
    print(matches)
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
        view.frame = CGRect(x: rect.minX - 2, y: rect.minY, width: rect.width + 4, height: rect.height + 2)
        // アプリケーションでビューオブジェクトを識別するために使用できる整数値です。
        // あとでViewを消すために、tagを設置
        view.tag = tagNo
        // 角丸
        view.layer.cornerRadius = 5
        
        uiView.addSubview(view)
        uiView.sendSubviewToBack(view)
        
    }

    
    return true
    
}

