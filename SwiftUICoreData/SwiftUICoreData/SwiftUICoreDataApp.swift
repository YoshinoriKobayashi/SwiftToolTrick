//
//  SwiftUICoreDataApp.swift
//  SwiftUICoreData
//
//  Created by yoshiiikoba on 2021/09/17.
//

import SwiftUI

@main
struct SwiftUICoreDataApp: App {
    // NSPersistentContainerの初期化
    // Core Dataを扱うための機能が全部入ったクラスで、アプリの起動時に生成されます。
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                // 環境変数@Environment(\.managedObjectContext)にNSManagedObjectContextを登録する処理
                // レコードの生成、保存、削除といったデータベース操作を行うクラスです。
                // Core Dataで検索や生成したオブジェクトは全てこのクラスの管理化に置かれます。
                // アプリ起動時に生成され、環境変数@Environment(\.managedObjectContext)に登録されます。
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
