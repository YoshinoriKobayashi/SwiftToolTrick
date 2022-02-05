//
//  FirebaseAuthStateManager.swift
//  SwiftUIFirebaseAuthentication
//
//  Created by yoshiiikoba on 2022/02/05.
//

import FirebaseAuth
//import Combine

class FirebaseAuthStateManager: ObservableObject {
    @Published var signInState: Bool = false
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
