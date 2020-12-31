//
//  TaskAppApp.swift
//  TaskApp
//
//  Created by Yoshinori Kobayashi on 2020/10/23.
//

import SwiftUI

@main
struct TaskAppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                             persistenceController.container.viewContext)
        }
    }
}
