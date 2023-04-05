//
//  Interactor.swift
//  SwiftUIVIPER
//
//  Created by Yoshinori Kobayashi on 2023/04/05.
//

import SwiftUI

// Interactorは、ビジネスロジックを担当し、データの取得や加工などのタスクを実行します。
// SwiftUIでは、InteractorはObservableObjectを採用したクラスとして実装されます。
class TodoInteractor: ObservableObject {
    @Published var todoItems: [TodoItem] = []

    func addTodoItem(title: String) {
        let newItem = TodoItem(id: todoItems.count, title: title, completed: false)
        todoItems.append(newItem)
    }

    func toggleTodoItem(todoItem: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == todoItem.id }) {
            todoItems[index].completed.toggle()
        }
    }
}
