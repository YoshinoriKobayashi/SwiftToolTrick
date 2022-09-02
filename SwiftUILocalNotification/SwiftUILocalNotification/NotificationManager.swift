//
//  NotificationManager.swift
//  SwiftUILocalNotification
//
//  Created by Swift-Beginners on 2022/09/02.
//

import Foundation
import UserNotifications

// notificationを管理するNotificationManager.swift
final class NotificationManager {
    static let instance: NotificationManager = NotificationManager()
    
    // notificationの権限を求めるrequestPermission()メソッドを作成
    func requestPermission() {
//        メソッド内に書いている.requestAuthorization()でPermission許可のアラートが出てきます。
//        .requestAuthorization()のオプションとしては
//        - .alert
//        - .sound
//        - .badge
//        の３つがあります。
//        プッシュ通知が来る際に指定したオプションで来るようになります。

        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert,.sound,.badge]) { granted, _ in
                print("Permission granted: \(granted)")
            }
    }
    
    // notificationを登録するsendNotification()メソッドを作成
    func sendNotification() {
        // UNMutableNotificationContent()でプッシュ通知のタイトル、内容などの指定を行います。
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.body  = "Local Notification Test"
        
        // トリガーの設定もUNTimeIntervalNotificationTrigger()を用いて定義
        // 今回はtimeInterval: 5にして5秒後にプッシュ通知が来るように設定
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // 他のnotificationトリガーを使いたい場合は、以下のリンクを参照してください。
        // - UNCalendarNotificationTrigger
        // - UNLocationNotificationTrigger
        // - UNPushNotificationTrigger
        
        let request = UNNotificationRequest(identifier: "notification01", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
