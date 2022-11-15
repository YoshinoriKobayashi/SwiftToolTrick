/*
See LICENSE folder for this sample’s licensing information.

Abstract:
NSTextLayoutFragment subclass to draw the comment bubble.
*/

#if os(iOS)
import UIKit
#else
import Cocoa
#endif
import CoreGraphics

// LayoutFragmentが同じ属性を適用するフレーズ
// テキスト要素のレイアウト情報
// NSTextLayoutFragmentのサブクラスを使って、コメントのレイアウトフラグメントの配置とカスタム描写に対処
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
        // textLineFragmentsは、LayoutFragmentは3つのプロパティのうちの１つ
        // NSTextLineFragment型：テキストレイアウトフラグメント内の1つのテキストレイアウト
        // とレンダリングユニットであるラインフラグメントを表すクラスです。
        // LineFragmentはレイアウトフラグメント内のテキストの各行の測定情報を含みます
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
    
    private var bubbleColor: Color { return .systemIndigo }

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