//
//  FirebaseUIView.swift
//  SwiftUIFirebaseAuthentication
//
//  Created by yoshiiikoba on 2022/02/05.
//

import SwiftUI
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI
//import FirebaseFacebookAuthUI
//import FirebasePhoneAuthUI
struct FirebaseUIView: UIViewControllerRepresentable {
    @Binding var isShowSheet: Bool
    
    class Coordinator: NSObject,
                       FUIAuthDelegate {
        
        // FirebaseUIView型の変数を用意
        let parent: FirebaseUIView
        
        // イニシャライザ
        init(_ parent: FirebaseUIView) {
            self.parent = parent
        }
        
        // MARK: - FUIAuthDelegate
        func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
            // handle user and error as necessary
            if let error = error {
                // サインイン失敗
                print("Auth NG:\(error.localizedDescription)")
            }
            if let _ = user {
                // サインイン成功
            }
            
            // Sheet（ModalView）を閉じる
            parent.isShowSheet = false
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        // Coordinatorクラスのインスタンスを作成
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let authUI = FUIAuth.defaultAuthUI()!
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI.delegate = context.coordinator
        // サポートするログイン方法を構成
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI),
            //            FUIFacebookAuth(authUI: authUI),
            //            FUIOAuth.twitterAuthProvider(),
            //            FUIPhoneAuth(authUI:authUI),
            FUIOAuth.appleAuthProvider(),
        ]
        authUI.providers = providers
        
        // FirebaseUIを表示する
        let authViewController = authUI.authViewController()
        
        return authViewController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
}
