//
//  SwiftUILocalNotificationApp.swift
//  SwiftUILocalNotification
//
//  Created by Swift-Beginners on 2022/09/02.
//

import SwiftUI

@main
struct SwiftUILocalNotificationApp: App {
    
    // @mainにAppDelegateをアダプターとして定義
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
