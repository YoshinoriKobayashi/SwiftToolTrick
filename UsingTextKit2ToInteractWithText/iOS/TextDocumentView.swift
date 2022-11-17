/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The application's primary view for managing text.
*/

import UIKit

class TextDocumentLayer: CALayer {
    override class func defaultAction(forKey event: String) -> CAAction? {
        // Suppress default animation of opacity when adding comment bubbles.
        return NSNull()
    }
}

// このTextDocumentViewがUITextViewのかわり。
// 独自のViewを作っている
// StoryboardでScrollViewで定義している。そのクラスに設定されている

// NSTextViewportLayoutControllerDelegate
// ビューポートレイアウトの変更に対応するためにデリゲートが実装するオプションのメソッドです。
// ViewPortが処理するエリアになる。常にViewPortに表示されている場合はいらない

// UIScrollViewがポイント
// UITextVeiwは、UIScrollViewを引き継ぎTextKitの機能を追加したコントロール。
// UIScrollViewから作ることで、オリジナルのTextViewが作れる。
class TextDocumentView: UIScrollView,
                        NSTextViewportLayoutControllerDelegate,
                        NSTextLayoutManagerDelegate,
                        UIGestureRecognizerDelegate {

    let selectionColor = UIColor.systemBlue
    let caretColor = UIColor.tintColor
    
    // MARK: - NSTextViewportLayoutControllerDelegate
    // 現在のビューポート（ビューの可視範囲とオーバードロー領域）を返します。
    func viewportBounds(for textViewportLayoutController: NSTextViewportLayoutController) -> CGRect {
        var rect = CGRect()
        rect.size = contentSize
        rect.origin = contentOffset
        return rect
    }

//    func viewportAnchor() -> CGPoint {
//        return CGPoint()
//    }

    // テキストビューポートレイアウトコントローラがレイアウト処理を終了したときに、フレームワークが呼び出すメソッド。
    // ビューポートに要素を配置する前にレイアウトコントローラがwillLayoutメソッドを呼び出します。
    // ここで ビューまたはレイヤーのコンテンツをクリアにするなど、レイアウトの準備のための設定を行います。
    func textViewportLayoutControllerWillLayout(_ controller: NSTextViewportLayoutController) {
        contentLayer.sublayers = nil
        CATransaction.begin()
    }
    
    private func animate(_ layer: CALayer, from source: CGPoint, to destination: CGPoint) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = source
        animation.toValue = destination
        animation.duration = slowAnimations ? 2.0 : 0.3
        layer.add(animation, forKey: nil)
    }
    
    private func findOrCreateLayer(_ textLayoutFragment: NSTextLayoutFragment) -> (TextLayoutFragmentLayer, Bool) {
        if let layer = fragmentLayerMap.object(forKey: textLayoutFragment) as? TextLayoutFragmentLayer {
            return (layer, false)
        } else {
            let layer = TextLayoutFragmentLayer(layoutFragment: textLayoutFragment, padding: padding)
            fragmentLayerMap.setObject(layer, forKey: textLayoutFragment)
            return (layer, true)
        }
    }
                    
    // レイアウトコントローラーがUIにテキストレイアウトの断片をレイアウトするときにフレームワークが呼び出すメソッド。
    func textViewportLayoutController(_ textViewportLayoutController: NSTextViewportLayoutController,
                                      configureRenderingSurfaceFor textLayoutFragment: NSTextLayoutFragment) {
        
        let (textLayoutFragmentLayer, didCreate) = findOrCreateLayer(textLayoutFragment)
        if !didCreate {
            let oldPosition = textLayoutFragmentLayer.position
            let oldBounds = textLayoutFragmentLayer.bounds
            textLayoutFragmentLayer.updateGeometry()
            if oldBounds != textLayoutFragmentLayer.bounds {
                textLayoutFragmentLayer.setNeedsDisplay()
            }
            if oldPosition != layer.position {
                animate(textLayoutFragmentLayer, from: oldPosition, to: textLayoutFragmentLayer.position)
            }
        }
        
        contentLayer.addSublayer(textLayoutFragmentLayer)
    }
    
    func textViewportLayoutControllerDidLayout(_ controller: NSTextViewportLayoutController) {
        CATransaction.commit()
        updateSelectionHighlights()
        updateContentSizeIfNeeded()
        adjustViewportOffsetIfNeeded()
    }
    
    private func adjustViewportOffsetIfNeeded() {
        let viewportLayoutController = textLayoutManager!.textViewportLayoutController
        let contentOffset = bounds.minY
        if contentOffset < bounds.height &&
            viewportLayoutController.viewportRange!.location.compare(textLayoutManager!.documentRange.location) == .orderedDescending {
            // Nearing top, see if we need to adjust and make room above.
            adjustViewportOffset()
        } else if viewportLayoutController.viewportRange!.location.compare(textLayoutManager!.documentRange.location) == .orderedSame {
            // At top, see if we need to adjust and reduce space above.
            adjustViewportOffset()
        }
    }
    
    private func adjustViewportOffset() {
        let viewportLayoutController = textLayoutManager!.textViewportLayoutController
        var layoutYPoint: CGFloat = 0
        textLayoutManager!.enumerateTextLayoutFragments(from: viewportLayoutController.viewportRange!.location,
                                                        options: [.reverse, .ensuresLayout]) { layoutFragment in
            layoutYPoint = layoutFragment.layoutFragmentFrame.origin.y
            return true
        }
        if layoutYPoint != 0 {
            let adjustmentDelta = bounds.minY - layoutYPoint
            viewportLayoutController.adjustViewport(byVerticalOffset: adjustmentDelta)
            let point = CGPoint(x: self.contentOffset.x, y: self.contentOffset.y + adjustmentDelta)
            setContentOffset(point, animated: true)
        }
    }
    
    private func updateSelectionHighlights() {
        if !textLayoutManager!.textSelections.isEmpty {
            selectionLayer.sublayers = nil
            for textSelection in textLayoutManager!.textSelections {
                for textRange in textSelection.textRanges {
                    textLayoutManager!.enumerateTextSegments(in: textRange,
                                                             type: .highlight,
                                                             options: []) {(textSegmentRange, textSegmentFrame, baselinePosition, textContainer) in
                        var highlightFrame = textSegmentFrame
                        highlightFrame.origin.x += padding
                        let highlight = TextDocumentLayer()
                        if highlightFrame.size.width > 0 {
                            highlight.backgroundColor = selectionColor.cgColor
                        } else {
                            highlightFrame.size.width = 1 // Fatten up the cursor.
                            highlight.backgroundColor = caretColor.cgColor
                        }
                        highlight.frame = highlightFrame
                        selectionLayer.addSublayer(highlight)
                        return true // Keep going.
                    }
                }
            }
        }
    }
    
    private var contentLayer: CALayer! = nil
    private var selectionLayer: CALayer! = nil
    private var fragmentLayerMap: NSMapTable<NSTextLayoutFragment, CALayer>
    private var padding: CGFloat = 5.0

    var textLayoutManager: NSTextLayoutManager? {
        willSet {
            // 変更前にすでにセットされていたら、初期化する
            if let tlm = textLayoutManager {
                tlm.delegate = nil
                tlm.textViewportLayoutController.delegate = nil
            }
        }
        didSet {
            // 変更後にセットされていたらデリゲートをセットする
            if let tlm = textLayoutManager {
                tlm.delegate = self
                tlm.textViewportLayoutController.delegate = self
            }
            updateContentSizeIfNeeded()
            updateTextContainerSize()
            layer.setNeedsLayout()
        }
    }
    // NSTextContentStorageはコンテンツマネージャで
    // NSTextStorageをバッキングストア（裏で保存している（所））として利用します
    var textContentStorage: NSTextContentStorage!
        
    override func layoutSublayers(of layer: CALayer) {
        assert(layer == self.layer)
        textLayoutManager?.textViewportLayoutController.layoutViewport()
        updateContentSizeIfNeeded()
    }
    
    @IBOutlet var viewController: TextDocumentViewController!
    
    var showLayerFrames: Bool = false
    var slowAnimations: Bool = false
    
    private func updateTextContainerSize() {
        let textContainer = textLayoutManager!.textContainer
        if textContainer != nil && textContainer!.size.width != bounds.width {
            textContainer!.size = CGSize(width: bounds.size.width, height: 0)
            layer.setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        fragmentLayerMap = .weakToWeakObjects()
        
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fragmentLayerMap = .weakToWeakObjects()
        
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layer.backgroundColor = UIColor.white.cgColor
        selectionLayer = TextDocumentLayer()
        contentLayer = TextDocumentLayer()
        layer.addSublayer(selectionLayer)
        layer.addSublayer(contentLayer)
        fragmentLayerMap = NSMapTable.weakToWeakObjects()
        padding = 5.0
        translatesAutoresizingMaskIntoConstraints = false

        addLongPressGestureRecognizer()
    }
    
    func updateContentSizeIfNeeded() {
        let currentHeight = bounds.height
        var height: CGFloat = 0
        textLayoutManager!.enumerateTextLayoutFragments(from: textLayoutManager!.documentRange.endLocation,
                                                        options: [.reverse, .ensuresLayout]) { layoutFragment in
            height = layoutFragment.layoutFragmentFrame.maxY
            return false // stop
        }
        height = max(height, contentSize.height)
        if abs(currentHeight - height) > 1e-10 {
            let contentSize = CGSize(width: self.bounds.width, height: height)
            self.contentSize = contentSize
        }
    }
    
    // addComment
    // comment:
    // コメント入力後のstarageへの追加
    func addComment(_ comment: NSAttributedString, below parentFragment: NSTextLayoutFragment) {
        guard let fragmentParagraph = parentFragment.textElement as? NSTextParagraph else { return }
        
        if let fragmentDepthValue = fragmentParagraph.attributedString.attribute(.commentDepth, at: 0, effectiveRange: nil) as? NSNumber? {
            let fragmentDepth = fragmentDepthValue?.uintValue ?? 0
            
            // コメントをattributedStringで作成
            let commentWithNewline = NSMutableAttributedString(attributedString: comment)
            // 最後に改行を追加
            commentWithNewline.append(NSAttributedString(string: "\n"))
            
            // Apply our comment attribute to the entire range.
            // "TK2DemoCommentDepth"というキー名でコメントに属性を追加
            commentWithNewline.addAttribute(.commentDepth,
                                            value: NSNumber(value: fragmentDepth + 1),
                                            range: NSRange(location: 0, length: commentWithNewline.length))
            
            let insertLocation = parentFragment.rangeInElement.endLocation
            // fromとtoの間のオフセットを返す。戻り値は正または負である。
            // オフセットが整数値で表現できない場合（つまり、場所が同じドキュメント内にない場合）、
            // NSNotFound を返す可能性があります。
            let insertIndex = textLayoutManager!.offset(from: textLayoutManager!.documentRange.location, to: insertLocation)
            // アクティブな編集トランザクションを制御するprimaryTextLayoutManagerによって呼び出される。
            // ネストすることができる。最も外側のトランザクションはhasEditingTransactionをトグルし、
            // トランザクションを起動した後に有効であれば同期メッセージを送信する。
            textContentStorage!.performEditingTransaction {
                // コメント途中に追加
                textContentStorage!.textStorage?.insert(commentWithNewline, at: insertIndex)
            }
            // 現在の子Viewの配置を無効にし、次の更新サイクルで配置し直すようにする(メインスレッドから呼ぶこと)。
            // このメソッドは即時の更新を強制するものではなく、次の更新サイクルを待つので、更新要求を書き留めたらすぐに処理を戻す。
            layer.setNeedsLayout()
        }
    }
    
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
        // commentDepthValueには数字が入る
        
        let commentDepthValue = textContentStorage!.textStorage!.attribute(.commentDepth, at: index, effectiveRange: nil) as! NSNumber?
        if commentDepthValue != nil {
            // textElementは、NSTextElement型→ここでテキスト属性
            // textElement.elementRangeは、NSTextRange型→ココで範囲
            // 角丸（バブル）のレイアウトを適用
            let layoutFragment = BubbleLayoutFragment(textElement: textElement, range: textElement.elementRange)
            layoutFragment.commentDepth = commentDepthValue!.uintValue
            return layoutFragment
        } else {
            return NSTextLayoutFragment(textElement: textElement, range: textElement.elementRange)
        }
    }
    
    // MARK: - Long Press Gesture Recognizer
    
    func addLongPressGestureRecognizer() {
        let longPressGestureRecognizer =
            UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc
    func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }

        var longPressPoint = gestureRecognizer.location(in: self)
        longPressPoint.x -= padding
        
        if let layoutFragment = textLayoutManager!.textLayoutFragment(for: longPressPoint) {
            // コメントの表示
            viewController.showCommentPopoverForLayoutFragment(layoutFragment)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
