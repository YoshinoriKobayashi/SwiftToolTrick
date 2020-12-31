//
//  ViewController.swift
//  UIKit004
//
//  Created by yoshiiikoba on 2020/09/07.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    private var myTextField: UITextField!
    
    override func viewDidLoad() {
                
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UITextFieldの配置するx,yと幅と高さを設定
        let tWidth: CGFloat = 200
        let tHeight: CGFloat = 30
        let posX: CGFloat = (self.view.bounds.width - tWidth) / 2
        let posY: CGFloat = (self.view.bounds.height - tHeight) / 2
        
        // UITextFieldを作成する
        myTextField = UITextField(frame: CGRect(x: posX,y: posY,width: tWidth,height: tHeight))
        
        // 表示する文字を代入する
        myTextField.text = "Hello TextField"
        
        // Delegateを自信に設定する
        myTextField.delegate = self
        
        // 枠を表示する
        myTextField.borderStyle = .roundedRect
        
        // クリアボタンを追加
        myTextField.clearButtonMode = .whileEditing
        
        // Viewに追加する
        self.view.addSubview(myTextField)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // UITextFieldが編集された直前に呼ばれる
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
    }
    
    // UITextFieldが編集された直後に呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing: \(textField.text!)")
    }
    
    // 改行ボタンが押された際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        
        // 改行ボタンが押されたらKeyboardを閉じる処理
        textField.resignFirstResponder()
        
        return true
    }


}

