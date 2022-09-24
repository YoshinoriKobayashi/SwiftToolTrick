//
//  Persistence.swift
//  SwiftUICoreDataTemplate
//
//  Created by Yoshinori Kobayashi on 2022/09/25.
//

import CoreData

// Persistenceは持続性の意味
// PersistenceControllerは独自の定義で、CoreDataのライブラリとかではない。
struct PersistenceController {
    // シングルトンで生成
    static let shared = PersistenceController()

    // プレビューで使うデータを定義している。クロージャ
    static var preview: PersistenceController = {
        // PersistenceControllerのインスタンス化
        // inMemory:trueで書き込みはメモリ内でするようにしている
        let result = PersistenceController(inMemory: true)
        //  NSManagedObjectContext
        let viewContext = result.container.viewContext
        
        // *** ここでテストデータを作成 ***
        // 10件のデータを作成
        for _ in 0..<10 {
            // ItemはCoreDataのエンティティ名
            // データ1件を新規作成
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        
        do {
            // NSManagedObjectContextを利用してセーブ
            // このときにinMemoryがtrueのときはメモリにセーブされる
            try viewContext.save()
        } catch {
            // この実装を、エラーを適切に処理するコードに置き換えてください。fatalError() は、アプリケーションにクラッシュログを生成させ、終了させます。この関数は、開発中には便利かもしれませんが、出荷時のアプリケーションでは使用しないでください。
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    // NSPersistentContainer
    // CoreDataを管理する親オブジェクト
    // アプリ内のCoreDataスタックをカプセル化するコンテナです。
    // iOS 10系から導入。NSManagedObjectModel, NSPersistentStoreCoordinator, NSManagedObjectContext のあたりを上手く生成・管理してくれる。
    let container: NSPersistentContainer

    // イニシャライザ
    // inMemoryの場合はメモリに書き込むような処理になる。
    init(inMemory: Bool = false) {
        // NSPersistentContainer：アプリ内のCore Dataスタックをカプセル化するコンテナです。
        // name:指定された名前のコンテナを作成する。このコンテナとCoreDataのエーブル名が一致している。
        // CoreDataのテーブル全体を管理するイメージ。
        container = NSPersistentContainer(name: "SwiftUICoreDataTemplate")
        //
        if inMemory {
            // CoreDataのファイルの場所をnullにすると、メモリ内を読み書きする仕様みたい
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        // storeDescriptions プロパティから、まだコンテナに正常に追加されていないストアをロードする。
        // 完了ハンドラは、成功または失敗した各ストアごとに 1 回呼び出される。 
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // storeDescriptionには次のような値が入っている
            // (type: SQLite, url: file:///Users/yoshiiikoba/Library/Developer/CoreSimulator/Devices/98A719F2-EBE7-4D53-8BDC-04B0963925BE/data/Containers/Data/Application/6768DF39-34B2-41B3-8BB7-7FFA33F993C4/Library/Application%20Support/SwiftUICoreDataTemplate.sqlite)
            if let error = error as NSError? {
                // この実装を、エラーを適切に処理するコードに置き換えてください。 
                // fatalError() は、アプリケーションにクラッシュログを生成させ、終了させます。
                // この関数は、開発中には有用かもしれませんが、出荷時のアプリケーションでは使用しないでください。

                /*
                 ここでエラーが発生する代表的な理由は以下の通りです。
                 * 親ディレクトリが存在しないか、作成できないか、または書き込みを禁止しています。
                 * デバイスがロックされている場合、パーミッションまたはデータ保護により、永続ストアにアクセスできません。
                 * デバイスの容量が足りない。
                 * ストアは現行モデルのバージョンに移行することができませんでした。
                 エラーメッセージを確認し、実際の問題が何であったかを判断してください。
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        // コンテキストが、persistent store コーディネータまたは親コンテキストに保存された変更を自動的にマージするかどうかを示すブール値です。
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
