//
//  TextDocumentView.swift
//  TextHighlight
//
//  Created by Yoshinori Kobayashi on 2022/11/15.
//
import UIKit

// カスタマイズ用に独自のコントールを作る：Viewの部分
class TextDocumentView: UIScrollView,
                        NSTextViewportLayoutControllerDelegate,
                        NSTextLayoutManagerDelegate {
    
    
    // MARK: - NSTextViewportLayoutControllerDelegate
    // 現在のビューポート（ビューの可視範囲とオーバードロー領域）を返します。
    func viewportBounds(for textViewportLayoutController: NSTextViewportLayoutController) -> CGRect {
        var rect = CGRect()
        rect.size = contentSize
        rect.origin = contentOffset
        return rect
    }
    func textViewportLayoutController(_ textViewportLayoutController: NSTextViewportLayoutController, configureRenderingSurfaceFor textLayoutFragment: NSTextLayoutFragment) {
        <#code#>
    }

    
    var textLayoutManager: NSTextLayoutManager? {
        willSet {
            // 変更前にすでにセットされていたら、初期化する
            if let tlm = textLayoutManager {
                tlm.delegate = nil
            }
        }
        didSet {
            // 変更後にセットされていたらデリゲートをセットする
            if let tlm = textLayoutManager {
                tlm.delegate = self
            }
        }
    }
    
    
    // NSTextContentStorageはコンテンツマネージャで
    // NSTextStorageをバッキングストア（裏で保存している（所））として利用します
    var textContentStorage: NSTextContentStorage!
 
    
    // MARK: - NSTextLayoutManagerDelegate
    // NSTextLayoutFragmentの管理
    // textElement 内の位置に対する NSTextLayoutFragment を返します。NSTextLayoutManagerDelegate は、レンダリングサーフェスの対象となる NSTextElement サブクラスに特化した NSTextLayoutFragment を提供することができます。
    // レイアウトマネージャが要素からレイアウトフラグメントを生成する時に、このメソッドが呼び出されます。
    // レイアウトマネージャのデリゲートで カスタムフラグメントのインスタンスを提供
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
//        let commentDepthValue = textContentStorage!.textStorage!.attribute(.commentDepth, at: index, effectiveRange: nil) as! NSNumber?
//        if commentDepthValue != nil {
            // textElementは、NSTextElement型→ここでテキスト属性
            // textElement.elementRangeは、NSTextRange型→ココで範囲
            // 角丸（バブル）のレイアウトを適用
            let layoutFragment = BubbleLayoutFragment(textElement: textElement, range: textElement.elementRange)
//            layoutFragment.commentDepth = commentDepthValue!.uintValue
            return layoutFragment
//        } else {
//            return NSTextLayoutFragment(textElement: textElement, range: textElement.elementRange)
//        }
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
