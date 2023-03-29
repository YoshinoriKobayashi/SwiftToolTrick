import UIKit

//let sentence = "the cat sat on the mat"
//let regularAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
//let largeAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
//let attributedSentence = NSMutableAttributedString(string: sentence, attributes: regularAttributes)
//
//attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 0, length: 3))
//attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 8, length: 3))
//attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 15, length: 3))
//
//attributedSentence.enumerateAttribute(.font, in: NSRange(0..<attributedSentence.length)) { value, range, stop in
//    if let font = value as? UIFont {
//        // make sure this font is actually bold
//        if font.fontDescriptor.symbolicTraits.contains(.traitBold) {
//            // it's bold, so make it red too
//            attributedSentence.addAttribute(.foregroundColor, value: UIColor.red, range: range)
//        }
//    }
//}
//print(attributedSentence)


//let attributedString = NSMutableAttributedString(string: "Hello World")
//attributedString.addAttribute(.roundedBackgroundColor, value: UIColor.red, range: NSRange(location: 0, length: attributedString.length))

// 属性キーの追加
//let myAttributeKey = NSAttributedString.Key("myAttributeKey")
//
//let string = "Hello, World!"
//let attrString = NSMutableAttributedString(string: string)
//attrString.addAttribute(myAttributeKey, value: "My custom value", range: NSRange(location: 0, length: string.utf16.count))

// カスタムキー
// _Commonに配置すればいい??
//class EDAttributedString {
//    // 属性キーの追加
//    public static let roundedBackgroundColor = NSAttributedString.Key("roundedBackgroundColor")
//}

//extension NSAttributedString {
//    public static let roundedBackgroundColor = NSAttributedString.Key("roundedBackgroundColor")
//}


// 独自の属性キーを作成するには、NSAttributedStringに拡張を行います。次はその例です
// ここで、独自の属性キーを表す拡張を作成しています。そして、この拡張を使用してNSAttributedStringのインスタンスに属性を追加することができます。
extension NSAttributedString.Key {
    static let roundedBackgroundColor = NSAttributedString.Key("myAttributeKey")
}

let string = "Hello, World!"
let attrString = NSMutableAttributedString(string: string)
attrString.addAttribute(.roundedBackgroundColor, value:UIColor.red , range: NSRange(location: 0, length: string.utf16.count))


//
//// ViewModelに設置
//let attributedString = NSMutableAttributedString(string: "Hello World")
//// カスタムキーに配色を指定
//attributedString.addAttribute(., value: UIColor.red, range: NSRange(location: 0, length: attributedString.length))

// UITextのときにカスタムキーがあれば背景を描画する。
// キーを取り出して装飾する
attrString.enumerateAttribute(.roundedBackgroundColor, in: NSRange(0..<attrString.length)) { value, range, stop in
    if let color = value as? UIColor {
        print("背景を角丸にして、colorで色を塗る:", color)
    }
}
