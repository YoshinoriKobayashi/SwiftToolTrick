//
//  AppDelegate.swift
//  SwiftUILocalNotification
//
//  Created by Swift-Beginners on 2022/09/02.
//

import Foundation

// アプリ起動時に権限を求める場合は、AppDelegateでその設定を行います。
// ただし、SwiftUIのプロジェクトには基本的にAppDelegate.swiftがないので、新しく追加する必要があります。
// 実は、SwiftUIプロジェクトの@main内でAppDelegateクラスを定義することもできますが、
// 今回は別のファイルとして定義したいと思います。

import Foundation
import NotificationCenter
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // 権限リクエストのメソッド呼び出し
        NotificationManager.instance.requestPermission()
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}
