//
//  ViewController.swift
//  TextHighlight
//
//  Created by Yoshinori Kobayashi on 2022/10/27.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif
import CoreGraphics

class ViewController : UIViewController , NSTextLayoutManagerDelegate{

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
        
        // 角丸
        // addAttributesは属性値をkeyで指定できる。addAttributeとは違うので注意！
        // https://developer.apple.com/documentation/foundation/nsmutableattributedstring/1414304-addattributes
        newText.addAttributes(
            [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.red
            ],
            range: NSRange(25...29)
        )

        // iOS15でTextKit2が導入されたので、この方法では動かない。
        textView.textContainer.replaceLayoutManager(CustomLayoutManager())
        textLabel.attributedText = newText
        textView.attributedText = newText
     }
    
    var textContentStorage: NSTextContentStorage!
    
    // MARK: - NSTextContentManagerDelegate
    

    
    // MARK: - NSTextLayoutManagerDelegate
    func textLayoutManager(_ textLayoutManager: NSTextLayoutManager,
                           textLayoutFragmentFor location: NSTextLocation,
                           in textElement: NSTextElement) -> NSTextLayoutFragment {
        let index = textLayoutManager.offset(from: textLayoutManager.documentRange.location, to: location)
        let commentDepthValue = textContentStorage!.textStorage!.attribute(.commentDepth, at: index, effectiveRange: nil) as! NSNumber?
        if commentDepthValue != nil {
            let layoutFragment = BubbleLayoutFragment(textElement: textElement, range: textElement.elementRange)
            layoutFragment.commentDepth = commentDepthValue!.uintValue
            return layoutFragment
        } else {
            return NSTextLayoutFragment(textElement: textElement, range: textElement.elementRange)
        }
    }
    
}


List {
      Text("Protty")
        .frame(height: 100)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
        .background(Color.red)
      if let functions = model.functions {
        ForEach(functions, id: \.self) { function in
          Section(header: sectionHeader(function: function, gp: gp)) {
            if let phrases = function.key_phrases {
              ForEach(phrases, id: \.self) {
                keyPhraseView(phrase: $0)
                if $0 != phrases.last { UIColor.edGreyLight.swiftUI.frame(height: 1) }
              }
              .listRowInsets(.init())
              .listRowSeparator(.hidden)
            }
          }
        }
      }
    }
    .listStyle(.plain)
    .environment(\.defaultMinListRowHeight, 0)
    .environment(\.defaultMinListHeaderHeight, 0)













class  CustomLayoutManager: NSLayoutManager {
    
    // 指定された範囲のグリフにアンダーラインを描きます。
    // https://developer.apple.com/documentation/uikit/nslayoutmanager/1403079-drawunderline
    override func drawUnderline(forGlyphRange glyphRange: NSRange, underlineType underlineVal: NSUnderlineStyle, baselineOffset: CGFloat, lineFragmentRect lineRect: CGRect, lineFragmentGlyphRange lineGlyphRange: NSRange, containerOrigin: CGPoint) {
        
        // glyphRange：
        // グリフの範囲。これは 1 つの線分矩形に属するものでなければなりません（ lineFragmentRect(forGlyphAt:effectiveRange:) が返すように）。
        // underlineVal:
        // 描画する下線のスタイル。この値は underlineStyle の値から派生したマスクで、例えば (NSUnderlinePatternDash | NSUnderlineStyleThick) となります。サブクラスは、カスタム下線スタイルを定義することができる。
        // baselineOffset：
        // 指定された範囲のグリフのバウンディングボックスの底辺からベースラインまでの距離を指定する。
        // lineRect：
        // 下線を引くグリフを含む線分矩形。
        // lineGlyphRange：
        // lineRect 内のすべてのグリフの範囲。
        // containerOrigin:
        // lineRectNSTextContainerのNSTextViewにおける原点。
            
        let firstPosition = location(forGlyphAt: glyphRange.location).x
        let lastPosition: CGFloat
        
        if NSMaxRange(glyphRange) < NSMaxRange(lineGlyphRange)  {
            lastPosition = location(forGlyphAt: NSMaxRange(glyphRange)).x
        } else {
            lastPosition = lineFragmentUsedRect(forGlyphAt: NSMaxRange(glyphRange) - 1, effectiveRange: nil).size.width
        }
        
        var lineRect = lineRect
        let height = lineRect.size.height * 3.5 / 4.0 // replace your under line height
        lineRect.origin.x += firstPosition
        lineRect.size.width = lastPosition - firstPosition
        lineRect.size.height = height
        
        lineRect.origin.x += containerOrigin.x
        lineRect.origin.y += containerOrigin.y
        
        lineRect = lineRect.integral.insetBy(dx: 0.5, dy: 0.5)
        
//        let path = UIBezierPath(rect: lineRect)
         let path = UIBezierPath(roundedRect: lineRect, cornerRadius: 3)
        // set your cornerRadius
        path.fill()
    }
    
    
}



class BubbleLayoutFragment: NSTextLayoutFragment {
    var commentDepth: UInt = 0

    override var leadingPadding: CGFloat { return 20.0 * CGFloat(commentDepth) }
    override var trailingPadding: CGFloat { return 50 }
    override var topMargin: CGFloat { return 6 }
    override var bottomMargin: CGFloat { return 6 }
    
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
