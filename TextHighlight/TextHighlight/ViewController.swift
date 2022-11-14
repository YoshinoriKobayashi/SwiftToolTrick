//
//  ViewController.swift
//  TextHighlight
//
//  Created by Yoshinori Kobayashi on 2022/10/27.
//

import UIKit

class ViewController : UIViewController{

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView! 

    private var textContentStorage: NSTextContentStorage
    private var textLayoutManager: NSTextLayoutManager
    private var fragmentForCurrentComment: NSTextLayoutFragment?
    
    required init?(coder: NSCoder) {
        
        textLayoutManager = NSTextLayoutManager()
        textContentStorage = NSTextContentStorage()
        super.init(coder: coder)

        textContentStorage.delegate = self
        textContentStorage.addTextLayoutManager(textLayoutManager)
        let textContainer = NSTextContainer(size: CGSize(width: 200, height: 0))
        textLayoutManager.textContainer = textContainer
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // 複数行の表示
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byClipping
        
         let text = "Mind can be observed and known. But you can know directly only your own mind, and not another's."
        
        let attributedText = NSMutableAttributedString(string:  text )
        attributedText.addAttributes([.backgroundColor: UIColor.cyan], range: NSRange(location: 12, length: 8))
        
//        
//        let layoutManager = LayoutManager()
//        layoutManager.backgroundCornerRadius = 5
//        
//        // iOS15でTextKit2が導入されたので、この方法では動かない。
//        textView.textContainer.replaceLayoutManager(layoutManager)
        textLabel.attributedText = attributedText
        textView.attributedText = attributedText
    }
}
//class LayoutManager: NSLayoutManager {
//
//    var backgroundCornerRadius: CGFloat = 0
//
//    override func fillBackgroundRectArray(_ rectArray: UnsafePointer<CGRect>, count rectCount: Int, forCharacterRange charRange: NSRange, color: UIColor) {
//        guard let context = UIGraphicsGetCurrentContext() else {
//            super.fillBackgroundRectArray(rectArray, count: rectCount, forCharacterRange: charRange, color: color)
//            return
//        }
//        context.saveGState()
//        defer { context.restoreGState() }
//        context.setFillColor(color.cgColor)
//
//        for rectIndex in 0..<rectCount {
//            let rect = rectArray.advanced(by: rectIndex).pointee
//            let path = UIBezierPath(roundedRect: rect, cornerRadius: backgroundCornerRadius)
//            context.addPath(path.cgPath)
//            context.fillPath()
//        }
//    }
//}

extension ViewController: NSTextContentManagerDelegate,
                          NSTextContentStorageDelegate {
    
    
    
}


extension ViewController: NSTextLayoutManagerDelegate {
    
    
    // MARK: - NSTextLayoutManagerDelegate
    // NSTextLayoutFragmentの管理
    // textElement 内の位置に対する NSTextLayoutFragment を返します。NSTextLayoutManagerDelegate は、レンダリングサーフェスの対象となる NSTextElement サブクラスに特化した NSTextLayoutFragment を提供することができます。
    // NSTextLayoutManager は、NSTextContentManager の持つ NSTextElement をNSTextLayoutFragment に変換していきます。
    func textLayoutManager(_ textLayoutManager: NSTextLayoutManager,
                           textLayoutFragmentFor location: NSTextLocation,
                           in textElement: NSTextElement) -> NSTextLayoutFragment {
        
        // NSTextLayoutManagerは、TextKitオブジェクトネットワークの中心的存在で、
        // NSTextContainerの配列を介してレイアウト形状を維持し、
        // オーナーNSTextContentManagerから渡された
        // NSTextElementに関連するNSTextLayoutFragmentでレイアウト結果を維持します。
        // offset：fromとtoの間のオフセットを返す。
        // 戻り値は正または負である。オフセットが整数値で表現できない場合（つまり、場所が同じドキュメント内にない場合）、NSNotFound を返す可能性があります。
        // 戻り値はInt型
        let index = textLayoutManager.offset(from: textLayoutManager.documentRange.location, to: location)
        // attribute(_:at:effectiveRange:)
        // 指定されたインデックスにある文字の指定された名前の属性に対応する値を返し、
        // 参照として、その属性が適用される範囲を返す。
        let commentDepthValue = textContentStorage.textStorage!.attribute(.commentDepth, at: index, effectiveRange: nil) as! NSNumber?
        if commentDepthValue != nil {
            // textElementは、NSTextElement型→ここでテキスト属性
            // textElement.elementRangeは、NSTextRange型→ココで範囲
            let layoutFragment = BubbleLayoutFragment(textElement: textElement, range: textElement.elementRange)
            layoutFragment.commentDepth = commentDepthValue!.uintValue
            return layoutFragment
        } else {
            return NSTextLayoutFragment(textElement: textElement, range: textElement.elementRange)
        }
    }
}


class BubbleLayoutFragment: NSTextLayoutFragment {
    var commentDepth: UInt = 0

    override var leadingPadding: CGFloat { return 20.0 * CGFloat(commentDepth) }
    override var trailingPadding: CGFloat { return 50 }
    override var topMargin: CGFloat { return 6 }
    override var bottomMargin: CGFloat { return 6 }
    
    // NSTextLayoutFragmentのinitが有効になっている
    // public init(textElement: NSTextElement, range rangeInElement: NSTextRange?)

    
    private var tightTextBounds: CGRect {
        var fragmentTextBounds = CGRect.null
        for lineFragment in textLineFragments {
            let lineFragmentBounds = lineFragment.typographicBounds
            if fragmentTextBounds.isNull {
                fragmentTextBounds = lineFragmentBounds
            } else {
                fragmentTextBounds = fragmentTextBounds.union(lineFragmentBounds)
            }
        }
        return fragmentTextBounds
    }
    
    // Return the bounding rect of the chat bubble, in the space of the first line fragment.
    private var bubbleRect: CGRect { return tightTextBounds.insetBy(dx: -3, dy: -3) }
    
    private var bubbleCornerRadius: CGFloat { return 20 }
    
    private var bubbleColor: UIColor { return .systemIndigo }

    private func createBubblePath(with ctx: CGContext) -> CGPath {
        let bubbleRect = self.bubbleRect
        let rect = min(bubbleCornerRadius, bubbleRect.size.height / 2, bubbleRect.size.width / 2)
        return CGPath(roundedRect: bubbleRect, cornerWidth: rect, cornerHeight: rect, transform: nil)
    }
    
    override var renderingSurfaceBounds: CGRect {
        return bubbleRect.union(super.renderingSurfaceBounds)
    }
    
    override func draw(at renderingOrigin: CGPoint, in ctx: CGContext) {
        // Draw the bubble and debug outline.
        ctx.saveGState()
        let bubblePath = createBubblePath(with: ctx)
        ctx.addPath(bubblePath)
        ctx.setFillColor(bubbleColor.cgColor)
        ctx.fillPath()
        ctx.restoreGState()
        
        // Draw the text on top.
        super.draw(at: renderingOrigin, in: ctx)
    }
}

extension NSAttributedString.Key {
    public static var commentDepth: NSAttributedString.Key {
        // NSAttributedString.Key：属性付き文字列のテキストに適用できる属性です。
        return NSAttributedString.Key("TK2DemoCommentDepth")
    }
}
