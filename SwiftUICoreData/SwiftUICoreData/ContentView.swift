//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by yoshiiikoba on 2021/09/17.
//

// サンプルコード
// https://capibara1969.com/3242/

import SwiftUI
import CoreData


struct ContentView: UIViewRepresentable {
    /// 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    
    /// データ取得処理
    // フェッチリクエストを行い、その結果をCore Dataストアから取得するプロパティのラッパータイプです。
    // Core Dataストアから結果を取得します。
    // フェッチリクエストとその結果は、環境値 ``EnvironmentValues/managedObjectContext` で提供されるマネージドオブジェクトコンテキストを使用します。
    // パラメーターに基づいてフェッチ・リクエストを定義することにより、インスタンスを作成します。
    // entity: フェッチするモデル化されたオブジェクトの種類.
    // sortDescriptors: ソートディスクリプターの配列は、フェッチされた結果のソート順を定義します。
    // predicate:NSPredicateは、フェッチされた結果に対するフィルタを定義します。.
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)], predicate: nil)
    
    //
    private var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            // 取得したデータをリスト表示
            List {
                ForEach(tasks) { task in
                    // タスクの表示
                    HStack {
                        if let checked = task.checked {
                            Image(systemName: checked ? "checkmark.circle.fill":"circle")
                        } else {
                            Image(systemName: "circle")
                        }
                        Text("\(task.name!)")
                        Spacer()
                    }
                    
                    ///  タスクをタップでcheckフラグを変更する
                    .contentShape(Rectangle())
                    .onTapGesture {
                        task.checked.toggle()
                        try? context.save()
                    }
                }
                .onDelete(perform: deleteTasks)
            }
            .navigationTitle("Todoリスト")
            
            // ツールバーの設定
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddTaskView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    /// タスクの削除
    /// - Parameter offsets: 要素番号コレクション
        func deleteTasks(offsets: IndexSet) {
            for index in offsets {
                context.delete(tasks[index])
            }
            try? context.save()
        }
}
/// タスク追加view
struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @State private var task = ""
    
    var body: some View {
        Form {
            Section() {
                TextField("タスクを入力", text: $task)
            }
        }
        .navigationTitle("タスク追加")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("保存") {
                    // タスク新規登録
                    let newTask = Task(context: context)
                    newTask.timestamp = Date()
                    newTask.checked = false
                    newTask.name = task
                    
                    try? context.save()
                    
                    // 現在のViewを閉じる
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
