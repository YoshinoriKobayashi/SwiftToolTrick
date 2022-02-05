//
//  CoreDataManager.swift
//  SwiftUICoreDataMVVM
//
//  Created by yoshiiikoba on 2022/01/23.
//

import Foundation
import CoreData

class CoreDataManager {
    // per:完全に、sis:すること、tent:伸ばすこと
    // persistent：持続的
    // con:ともに、tain：つかむ、er：人もの
    // container：入れ物と、コンテナ
    let persistentStoreContainer: NSPersistentContainer
    
    // NSPersistentContainer
    // アプリ内のCoreDataスタックをカプセル化するコンテナです。
    // NSPersistentContainerは、マネージドオブジェクトモデル（NSManagedObjectModel）、
    // 永続ストアコーディネータ（NSPersistentStoreCoordinator）、
    // マネージドオブジェクトコンテキスト（NSManagedObjectContext）の作成を処理し、
    // コアデータスタックの作成と管理を簡素化する。
    
    // シングルトン
    // 自動的に遅延初期化される（初回アクセスのタイミングでインタンス生成）
    // private init() と合わせて使う
    static let shared = CoreDataManager()
    
    private init() {
        // NSPersistentContainerのinit(name:)
        // デフォルトでは、提供された名前値が永続ストアの名前として使用され、
        // NSPersistentContainer オブジェクトで使用する NSManagedObjectModel
        // オブジェクトの名前を検索するために使用されます。
        // name：指定された名前のコンテナを作成する。NSPersistentContainer オブジェクトの名前。
        // Return Value：与えられた名前で初期化された永続的なコンテナ。
        persistentStoreContainer = NSPersistentContainer(name: "BudgetAppModel")
    }
    
    
}
