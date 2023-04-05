//
//  TodoPresenter.swift
//  SwiftUIVIPER
//
//  Created by Yoshinori Kobayashi on 2023/04/05.
//

import SwiftUI

// Presenterは、ViewとInteractorの間で通信を取り持ちます。
// Viewからの入力をInteractorに送り、Interactorからの応答をViewに戻します。
// Presenterは、ObservableObjectを採用したクラスとして実装されます。
class TodoPresenter: ObservableObject {
    @Published var todoItems: [TodoItem] = []
    @Published var todoItemTitle: String = ""

    private let interactor: TodoInteractor

    init(interactor: TodoInteractor) {
        self.interactor = interactor
        self.todoItems = interactor.todoItems
    }

    func addTodoItem() {
        interactor.addTodoItem(title: todoItemTitle)
        todoItemTitle = ""
        todoItems = interactor.todoItems
    }

    func toggleTodoItem(todoItem: TodoItem) {
        interactor.toggleTodoItem(todoItem: todoItem)
        todoItems = interactor.todoItems
    }
}
