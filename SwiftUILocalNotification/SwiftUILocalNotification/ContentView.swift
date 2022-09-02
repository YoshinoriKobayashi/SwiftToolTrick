//
//  ContentView.swift
//  SwiftUILocalNotification
//
//  Created by Swift-Beginners on 2022/09/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Local Notification Demo")
            .padding()
        // NotificationManagerのsendNotification()メソッドを呼び出すようにアクションを設定
        Button(action: { NotificationManager.instance.sendNotification() }) { 
            Text("Send Notification!!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
