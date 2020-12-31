//
//  ViewController.swift
//  FirebaseUISNSLogin
//
//  Created by yoshiiikoba on 2020/09/07.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI


class ViewController: UIViewController, FUIAuthDelegate {

    @IBOutlet weak var authButton: UIButton!
    
    @IBAction func authButton(_ sender: Any) {
        // FirebaseUIのViewの取得
        let authViewController = self.authUI.authViewController()
        // FirebaseUIのViewの表示
        self.present(authViewController, animated: true, completion: nil)

    }
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    // 認証に使用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // authUIのデリゲート
        self.authUI.delegate = self
        self.authUI.providers = providers
    }

    struct loginUser {
        var uid:String = "" 
        var email:String = ""
        var photoURL:URL! = nil
    }
    var userInfo = loginUser()


    
    //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        // 認証に成功した場合
        if error == nil {
            // ログインしている場合
            if let user = Auth.auth().currentUser {
                userInfo.uid = user.uid
                userInfo.email = user.email!
                userInfo.photoURL = user.photoURL
            }
            
            self.performSegue(withIdentifier: "toSuccessView", sender: self)

        }
        
    // エラー時の処理をここに書く
    }
    
    // segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueのIDを確認して特定のsegueのときのみ動作させる
        if segue.identifier == "toSuccessView" {
            // 遷移先のViewCOntrollerを取得
            let next = segue.description as? SuccessView
            // 用意した遷移先の変数に値を渡す
            next?.uid = userInfo.uid
            next?.email = userInfo.email
            next?.photoURL = userInfo.photoURL

            
        }
    }
}

