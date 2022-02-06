//
//  FirebaseAuthStateManager.swift
//  SwiftUIFirebaseAuthentication
//
//  Created by yoshiiikoba on 2022/02/05.
//

import FirebaseAuth
//import Combine

// observable（観測可能）
// モデルのデータ変更をSwiftUIから見えるようにするには、モデルクラスにObservableObjectプロトコルを採用
class FirebaseAuthStateManager: ObservableObject {
    // Published属性を付加して公開する。
    @Published var signInState: Bool = false
    
    // SwiftUIに監視させない、ローカルのみ
    // 双方が変更可能で、ユーザーインターフェースにとって重要なプロパティのみを公開します。
    private var handle: AuthStateDidChangeListenerHandle!
    
    init() {
        // https://firebase.google.com/docs/auth/ios/start
        // 認証状態をリッスンする
        // ログインしているユーザーに関する情報を必要とするアプリの各ビューに対して、FIRAuth オブジェクトにリスナーをアタッチします。このリスナーは、ユーザーのログイン状態が変わるたびに呼び出されます。
        // ビューコントローラの viewWillAppear メソッドでリスナーをアタッチします。
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in 
            if let _ = user {
                print("Sign-in")
                self.signInState = true
            } else {
                print("Sign-out")
                self.signInState = false
            }
        }
    }
    
    deinit() {
        // ビュー コントローラの viewWillDisappear メソッドでリスナーをデタッチします。
        Auth.auth().removeStateDidChangeListener(handle)
    }
}
