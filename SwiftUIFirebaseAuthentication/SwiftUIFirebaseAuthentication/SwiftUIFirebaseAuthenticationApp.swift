//
//  SwiftUIFirebaseAuthenticationApp.swift
//  SwiftUIFirebaseAuthentication
//
//  Created by yoshiiikoba on 2022/02/05.
//

import SwiftUI

// Firebase.configure()の設定
// https://qiita.com/From_F/items/eb0d6871d202ef10d927
// FirebaseApp 共有インスタンスを構成します。通常はアプリの application:didFinishLaunchingWithOptions: メソッドで行います。

@main
struct SwiftUIFirebaseAuthenticationApp: App {
    // アプリケーション開始時に何か初期化コードを実行したい
    // AppDelegate と SceneDelegate がなくなっている
    // https://www.yururiwork.net/archives/1163
    // SwiftUI App で AppDelegate を利用するには @UIApplicationDelegateAdaptor を使用
    // UIKitからのデリゲートを提供するためにアプリで使用されるプロパティラッパー。
    // https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// そして、UIApplicationDelegate プロトコルを継承した実体の AppDelegate クラスを定義
class AppDelegate: NSObject, UIApplicationDelegate {
    // https://firebase.google.com/docs/ios/setup?hl=ja#initialize-firebase
    // application:didFinishLaunchingWithOptions: メソッドで行います。
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        return true
    }
    
    // https://firebase.google.com/docs/auth/ios/google-signin
    // アプリのデリゲートに application:openURL:options: メソッドを実装します。このメソッドは GIDSignIn インスタンスの handleURL メソッドを呼び出します。これによって、認証プロセスの最後にアプリが受け取る URL が正しく処理されます。

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
}

