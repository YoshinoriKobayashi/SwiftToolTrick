//
//  ViewController.swift
//  TextHighlight
//
//  Created by Yoshinori Kobayashi on 2022/10/27.
//

import UIKit

class ViewController : UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 複数行の表示
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byClipping
        
        textLabel.text = "Mind can be observed and known. But you can know directly only your own mind, and not another's."
        
        textView.text = "Mind can be observed and known. But you can know directly only your own mind, and not another's."

//        
//        // フォントの指定
//        guard let originalFont = UIFont(name:"Comic Sans MS", size: 24.0) else { return }
//        // 太字の属性を作成
//        let boldFontDescriptor = originalFont.fontDescriptor.withSymbolicTraits(.traitBold)
//        // 
//        let boldFont = UIFont(descriptor: boldFontDescriptor!, size: (originalFont.pointSize))
        
        //
        // let newText = NSMutableAttributedString(attributedString: textLabel.attributedText!)
//        let newText = NSMutableAttributedString(string: textLabel.text!,attributes: [.font: originalFont])
        let newText = NSMutableAttributedString(string: textLabel.text!)
        //
//        newText.addAttribute(.font, value: boldFont, range: NSRange(location: 0, length: 4))
        
        // フォントの指定
        newText.addAttribute(.font, value: UIFont(name: "PartyLetPlain", size: 24)!,  range: NSRange(0...3))
        
        // 背景の指定
        newText.addAttribute(.backgroundColor, value: UIColor.green,  range: NSRange(12...19))
        
        textLabel.attributedText = newText
        textView.attributedText = newText
     }
}

