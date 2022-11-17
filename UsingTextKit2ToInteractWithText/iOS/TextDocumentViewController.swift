/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The application's primary view controller.
*/

import UIKit

// ここでは1画面なのでViewControllerにしている
class TextDocumentViewController: UIViewController,
                                  NSTextContentManagerDelegate,
                                  NSTextContentStorageDelegate,
                                  UIPopoverPresentationControllerDelegate {

    private var textContentStorage: NSTextContentStorage
    private var textLayoutManager: NSTextLayoutManager
    private var fragmentForCurrentComment: NSTextLayoutFragment?
    private var showComments = true
    var commentColor: UIColor { return .white }
    
    @IBOutlet var toggleComments: UIButton!

    var textDocumentView: TextDocumentView {
        get {
            return (view as? TextDocumentView)!
        }
    }

    required init?(coder: NSCoder) {
        textLayoutManager = NSTextLayoutManager()
        textContentStorage = NSTextContentStorage()
        super.init(coder: coder)
        textContentStorage.delegate = self
        // 提供されたレイアウトマネージャーをレイアウトマネージャーのリストに追加します。
        textContentStorage.addTextLayoutManager(textLayoutManager)
        // テキストレイアウトが行われる領域。
        // NSLayoutManager は NSTextContainer を使って、どこで改行するか、
        // テキストの一部をレイアウトするか、などを決定します。
        // NSTextContainer、NSLayoutManager、NSTextStorage クラスのインスタンスは、
        // アプリが一度に1つのスレッドからのアクセスを保証する限り、メインスレッド以外からアクセスすることが可能です。
        let textContainer = NSTextContainer(size: CGSize(width: 200, height: 0))
        // レイアウト先の幾何情報を提供するテキストコンテナオブジェクト。
        // isSimpleRectangularTextContainer=NOの場合、NSTextLayoutManagerは非連続レイアウトサポートを許可せず、常に上部から塗りつぶします。
        textLayoutManager.textContainer = textContainer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let docURL = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
            do {
                // ここでコンテンツをセット。
                try textContentStorage.textStorage?.read(from: docURL, documentAttributes: nil)
            } catch {
                // Could not read menu content.
            }
        }
        
        // This is called when the toggle comment button needs an update.
        let toggleUpdateHandler: (UIButton) -> Void = { [self] button in
            button.configuration?.image =
                button.isSelected ? UIImage(systemName: "text.bubble.fill") : UIImage(systemName: "text.bubble")
            self.showComments = button.isSelected
            // setNeedsLayout
            // frame更新要否のフラグを立てる 
            // 計算実行タイミングはシステム任せ
            textDocumentView.layer.setNeedsLayout()
        }
        toggleComments.configurationUpdateHandler = toggleUpdateHandler

        textDocumentView.textContentStorage = textContentStorage
        textDocumentView.textLayoutManager = textLayoutManager
        textDocumentView.updateContentSizeIfNeeded()
        textDocumentView.viewController = self
    }
    
    // Commenting
    
    var commentFont: UIFont {
        var commentFont = UIFont.preferredFont(forTextStyle: .title3)
        let commentFontDescriptor = commentFont.fontDescriptor.withSymbolicTraits(.traitItalic)
        commentFont = UIFont(descriptor: commentFontDescriptor!, size: commentFont.pointSize)
        return commentFont
    }
    
    // コメント追加されたとき
    func addComment(comment: NSAttributedString) {
        textDocumentView.addComment(comment, below: fragmentForCurrentComment!)
        fragmentForCurrentComment = nil
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
        // コメントが非表示のとき
        if !showComments {
            if let paragraph = textElement as? NSTextParagraph {
                let commentDepthValue = paragraph.attributedString.attribute(.commentDepth, at: 0, effectiveRange: nil)
                if commentDepthValue != nil {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: - NSTextContentStorageDelegate
    // NSTextContentStorageの正体は、NSTextContentManagerのデフォルト値。
    // NSTextParagraphは、デフォルトのエレメントタイプ（element type）
    // NSTextContentStorageは、テキストストレージ内のテキストが変更した時、更新された段落の要素を生成します。
    // textStorage の range で指定される部分について、どのような NSTextParagraph を作るかをカスタマイズするための delegate メソッドです。
    // 文字列はすでに Paragraph に該当する部分に分割されていますので、分割具合を変更することはできません。
    // なお この delegate は変更された部分についてのみ呼び出されます。
    // この delegate を設定しない、もしくは、このメソッドで nil を返すと、NSTextContentManager 側で NSTextParagraph を作成してくれます。
    // ですので、独自の NSTextParagraph を作りたい時には、この メソッドで作成して返し、通常の NSTextParagraph で良いのであれば、nil を返すことになります
    // NSTextParagraph は、任意の NSAttributedString から作成できますが、長さは、range.length と一致している必要があります。
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
    
    // MARK: - Popover Management
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none // This makes the comment popover view controller present as a popover on iPhone.
    }
    
    func showCommentPopoverForLayoutFragment(_ layoutFragment: NSTextLayoutFragment) {
        fragmentForCurrentComment = layoutFragment
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let popoverVC = storyboard.instantiateViewController(withIdentifier: "CommentPopoverViewController") as? CommentPopoverViewController {
            popoverVC.viewController = self
            // スタイルの指定
            popoverVC.modalPresentationStyle = .popover
            // サイズの指定
            popoverVC.preferredContentSize = CGSize(width: 420.0, height: 100.0)
            // 表示するViewの指定
            popoverVC.popoverPresentationController!.sourceView = self.textDocumentView
            // ピヨッと表示する位置の指定
            // layoutFragmentFrameは、レイアウトフラグメントのテキストがどのようにテキストコンテナ内での配置されるか規定します
            popoverVC.popoverPresentationController!.sourceRect = layoutFragment.layoutFragmentFrame
            // 矢印が出る方向の指定
            popoverVC.popoverPresentationController!.permittedArrowDirections = .any
            // デリゲートの設定
            popoverVC.popoverPresentationController!.delegate = self
            // 表示
            present(popoverVC, animated: true, completion: {
                //..
            })
        }
    }
    
}

