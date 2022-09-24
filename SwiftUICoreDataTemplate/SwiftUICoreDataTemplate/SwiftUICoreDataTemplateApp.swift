//
//  SwiftUICoreDataTemplateApp.swift
//  SwiftUICoreDataTemplate
//
//  Created by Yoshinori Kobayashi on 2022/09/25.
//

import SwiftUI

@main
struct SwiftUICoreDataTemplateApp: App {
    // PersistenceControllerのインスタンスを作成
    // PersistenceControllerは独自の定義で、CoreDataのライブラリとかではない。
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // managedObjectContextが環境変数
            // viewContextがCoreDataのテーブルを管理するオブジェクト
            // テーブルが複数の場合は、環境変数も複数になる。
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
