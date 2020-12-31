//
//  ViewController.swift
//  SimpleMessageKit
//
//  Created by Yoshinori Kobayashi on 2020/10/16.
//

import UIKit
import MessageKit

class ViewController: MessagesViewController {

    var messageList: [MockMessage] = []
    
    lazy var formatter: DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            // messageListにメッセージの配列をいれて
            self.messageList = self.getMessages()
            // messageCollectionViewをリロードして
            self.messagesCollectionView.reloadData()
            // 一番下までスクロールする
            self.messagesCollectionView.scrollToBottom()
        }
        
        messageCollectionView.messageDataSource = self
        messageCollectionView.messagesLayoutDelegate = self
        messageCollectionView.messagesDisplayDelegate = self
        messageCollectionView.messageCellDelegate = self
        
        messageInputBar.delegate = self
        messageInputBar.sendButton.tintColor = UIColor.lightGray
        
        // メッセージ入力前に一番下までスクロール
        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        
        
    }

    func getMessages() -> [MockMessage] {
        return [
            createMessage(text:"あ"),
            createMessage(text:"い"),
            createMessage(text:"う"),
            createMessage(text:"え"),
            createMessage(text:"お"),
            createMessage(text:"か"),
        ]
    }
    
    func createMessage(text: String) -> MockMessage {
        let attributedText = NSAttributedString(string: text,attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                          .foregroundColor: UIColor.black])
        return MockMessage(attributedText:attributedText, sender: otherSender(), messageId:UUID().uuidString,date:Date())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(id:"123",displayName: "自分")
    }
    func otherSender() -> Sender {
        return Sender(id:"456",displayName: "知らない人")
    }
    func numberOfSections(in messageCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    func messageForItem(at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    // メッセージの上に文字を表示
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            return NSAttributedString (
                string: MessageKitFormatter.shared.string(from: message.sentDate),
                attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 10),
                             NSAttributedStringKey.foregroundColor: UIColor.darkGray]
            )
        }
        return nil
    }
    
    // メッセージの上に文字を表示（名前）
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name,attributes: [NSAttributedStringKey.font:UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    // メッセージの下に文字を表示（日付）
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
    extension ViewController: MessagesDisplayDelegate {
        
        // メッセージの色を変更（デフォルトは自分：白、相手：黒）
        func textColor(for message: MessageType, at indexPath: IndexPath,in messagesCollectionView: MessagesCollectionView) -> UIColor {
            return isFromCurrentSender(message: message) ? .white : .darkText
        }
        
        // メッセージの背景色を変更している（デフォルトは自分：緑、相手：グレー）
        func backgroundColor(for message: MessageType,at indexPath: IndexPath,in messagesCollectionview: MessagesCollectionView) -> UIColor {
            return isFromCurrentSender(message: message)?
            UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1) :
                        UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        // メッセージの枠にしっぽを付ける
        func messageStyle(for message: MessageType,at indexPath: indexPath: IndexPath, in messagesCollectionView:MessagesCollectionView) -> MessageStyle {
            let corner: MessageStyle.TailCorner = isFromCurrentSender(message: (message:message) ? .bottomRight:.bottomLeft
            return .bubbleTail(corner,.curved)
        }
        
        // アイコンをセット
        func configureAvatarView(_ avatarView: AvatarView,for message: MessageType,at indexPath: Indexpath,in messageCollectionView: MessagesCollectionView) {
            // message.sender.displayNameとかで送信者の名前を取得できるので
            // そこからイニシャルを生成するとよい
            let avatar = Avatar(initials:"人")
            avatarView.set(avatar: avatar)
            
        }
    }
    
    // 各ラベルの高さを設定（デフォルト0なので必須）
    extension ViewController: MessagesLayoutDelegate {
        
        func cellTopLabelHeight(for message: MessageStyle,at indexPath: IndexPath, in messagesCollectioView: MessagesCollectionView) -> CGFloat {
            if indexPath.section % 3 == 0 { return 10 }
            return 0
        }
        func messageTopLabelHeight(for message: MessageType,at indexPath: IndexPath,in messagesCollectionView: MessagesCollectionView) -> CGFloat {
            return 16
        }
        func messageBottomLabelHeight(for message: MessageType,at indexPath: IndexPath: IndexPath, in messagesCollectionView: MessageCollectinView) -> CGFloat {
            return 16
        }
    }
    extension ViewController: MessageCellDelegate {
        // メッセージをタップしたときの挙動
        func didTapMessage(in cell: MessageCollectionViewCell) {
            print("Message tapped")
        }
    }
    
    extension ViewController: MessageInputBarDelegate {
        // メッセージ送信ボタンをタップしたときの挙動
        func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
            for component in inputBar.inputTextView.componets {
                if let image= component as? UIImage {
                    let imageMessage = MockMessage(image:image,sender:currentSender(),messageId: UUID().uuidString,date:Date())
                    messageList.append(imageMessage)
                    messagesCollectionView.insertSections([messageList.count -1])
                }
            }
            inputBar.inputTextView.text = String()
            messagesCollectionView.scrollToBottom()
        }
    }
    
    
    
    
    
    
    
    
}
