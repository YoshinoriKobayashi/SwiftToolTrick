//
//  ViewController.swift
//  TextHighlight
//
//  Created by Yoshinori Kobayashi on 2022/10/27.
//

import UIKit

class ViewController : UIViewController,
                       NSTextContentManagerDelegate,
                       NSTextContentStorageDelegate{

    private var textContentStorage: NSTextContentStorage
    private var textLayoutManager: NSTextLayoutManager
    private var fragmentForCurrentComment: NSTextLayoutFragment?

    @IBOutlet weak var textLabel: UILabel!

    var textDocumentView: TextDocumentView     
//    var textDocumentView: TextDocumentView {
//        get {
//            return (view as? TextDocumentView)! // エラーでおちる
//        }
//    }

    var commentFont: UIFont {
        var commentFont = UIFont.preferredFont(forTextStyle: .title3)
        let commentFontDescriptor = commentFont.fontDescriptor.withSymbolicTraits(.traitItalic)
        commentFont = UIFont(descriptor: commentFontDescriptor!, size: commentFont.pointSize)
        return commentFont
    }
    var commentColor: UIColor { return .white }
    
    required init?(coder: NSCoder) {
        textLayoutManager = NSTextLayoutManager()
        textContentStorage = NSTextContentStorage()
        // TextDocumentViewのインスタンス
        textDocumentView = TextDocumentView()
        super.init(coder: coder)
        textContentStorage.delegate = self
        // 提供されたレイアウトマネージャーをレイアウトマネージャーのリストに追加します。
        textContentStorage.addTextLayoutManager(textLayoutManager)
        // テキストレイアウトが行われる領域。
        // NSLayoutManager は NSTextContainer を使って、どこで改行するか、
        // テキストの一部をレイアウトするか、などを決定します。
        // NSTextContainer、NSLayoutManager、NSTextStorage クラスのインスタンスは、
        // アプリが一度に1つのスレッドからのアクセスを保証する限り、メインスレッド以外からアクセスすることが可能です。
        let textContainer = NSTextContainer(size: CGSize(width: 200, height: 100))
        // レイアウト先の幾何情報を提供するテキストコンテナオブジェクト。
//         isSimpleRectangularTextContainer=NOの場合、NSTextLayoutManagerは非連続レイアウトサポートを許可せず、常に上部から塗りつぶします。
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
//        textDocumentView.attributedText = attributedText
        
        textContentStorage.textStorage?.insert(attributedText,at: 0)
        textDocumentView.textContentStorage = textContentStorage
        textDocumentView.textLayoutManager = textLayoutManager
//        textDocumentView.viewController = self

    }
    
    // MARK: - NSTextContentManagerDelegate
    // ContentManagerはテキストを要素に分解し、それらを追跡します。
    // レイアウトの際にはNSTextLayoutMnagerがContentManagerに要素を照会します
    // NSTextContentManager は、入力されたテキストを、NSTextElement に分割します。
    // バッキングストア内のコンテンツに変更があると更新された範囲で新しい要素を生成します。
    func textContentManager(_ textContentManager: NSTextContentManager,
                            shouldEnumerate textElement: NSTextElement,
                            options: NSTextContentManager.EnumerationOptions) -> Bool {
        // NSTextElement：この要素がドキュメントを構成する。
        // テキストコンテンツマネージャはこのメソッドを呼び出して、各テキスト要素をレイアウトのために列挙すべきかどうかを判断する。
        // コメントを非表示にするには、テキストコンテンツマネージャーに、この要素がコメントである場合は列挙しないように指示します。
//        if !showComments {
//            if let paragraph = textElement as? NSTextParagraph {
//                let commentDepthValue = paragraph.attributedString.attribute(.commentDepth, at: 0, effectiveRange: nil)
//                if commentDepthValue != nil {
//                    return false
//                }
//            }
//        }
        return true
    }

    // MARK: - NSTextContentStorageDelegate
    // NSTextContentStorageの正体は、NSTextContentManagerのデフォルト値。
    // NSTextParagraphは、デフォルトのエレメントタイプ（element type）
    // NSTextContentStorageは、テキストストレージ内のテキストが変更した時、更新された段落の要素を生成します。
    func textContentStorage(_ textContentStorage: NSTextContentStorage, textParagraphWith range: NSRange) -> NSTextParagraph? {
        // このメソッドでは、テキストストレージを直接変更することなく、表示用の属性を注入します。
        var paragraphWithDisplayAttributes: NSTextParagraph? = nil
        
        // まず、元のテキストストレージから段落のコピーを取得します。
        let originalText = textContentStorage.textStorage!.attributedSubstring(from: range)
        if originalText.attribute(.commentDepth, at: 0, effectiveRange: nil) != nil {
            // 明るい背景の中で、私たちのコメントが見えるように、白色のテキストを使用してください。
            let displayAttributes: [NSAttributedString.Key: AnyObject] = [.font: commentFont, .foregroundColor: commentColor]
            let textWithDisplayAttributes = NSMutableAttributedString(attributedString: originalText)
            // リアクションを除いたコメントのテキストそのものにdisplay属性を使用します。
            // 最後の文字は改行、最後から2番目は反応の添付文字です。
            let rangeForDisplayAttributes = NSRange(location: 0, length: textWithDisplayAttributes.length - 2)
            textWithDisplayAttributes.addAttributes(displayAttributes, range: rangeForDisplayAttributes)
            
            // 表示属性を設定した新しい段落を作成します。
            paragraphWithDisplayAttributes = NSTextParagraph(attributedString: textWithDisplayAttributes)
        } else {
            return nil
        }
        // 元の段落がコメントでない場合、この戻り値はnilになる。
        // テキストコンテンツの保存は、この場合、元の段落を使用します。
        return paragraphWithDisplayAttributes
    }
}
