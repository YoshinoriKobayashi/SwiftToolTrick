//
//  SwiftUICoreDataTemplateApp.swift
//  SwiftUICoreDataTemplate
//
//  Created by Yoshinori Kobayashi on 2022/09/25.
//

import SwiftUI

@main
struct SwiftUICoreDataTemplateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
