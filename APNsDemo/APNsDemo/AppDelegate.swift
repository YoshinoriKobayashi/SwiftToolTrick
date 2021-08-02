//
//  AppDelegate.swift
//  APNsDemo
//
//  Created by Swift-Beginners on 2021/07/29.
//

import UIKit
import UserNotifications

@main
// UNUserNotificationCenterDelegate Add
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // ユーザーがアプリを初回起動する際にプッシュ通知の許可ダイアログが出る
        registerForPushNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // 追加した
    func registerForPushNotifications() {
        // UserNotificationCenterインスタンスにアクセスし、
        // ユーザーにアラート、サウンド、バッジを使ったプッシュ通知を送っていいか許可を取る
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound,.badge]) {
            (granted, error) in
            print("Permission granted:\(granted)")
            // 1.Check if permission granted
            guard granted else { return }
            // 2.Attempt registration for remote notifications on the main thread
            // 許可を取ることができたら、shared applicationインスタンスの
            // registerForRemoteNotifications()関数をmainスレッドで呼び出します。
            // ここでmainスレッドで呼び出さないとバックグラウンドでの実行となり、エラーメッセージが出てしまう。
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    //
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1.Covert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2.Print device token to use for PNS
    }

}

