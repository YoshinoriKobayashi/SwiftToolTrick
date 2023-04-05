//
//  TodoView.swift
//  SwiftUIVIPER
//
//  Created by Yoshinori Kobayashi on 2023/04/05.
//

import SwiftUI

// SwiftUIでは、Viewはビューとロジックの両方を含んでいますが、
// VIPERフレームワークでは、Viewはビューのみを担当し、
// ロジックはPresenterに移行されます。Viewは、SwiftUIのViewプロトコルに準拠する必要があります。
struct TodoView: View {
    @StateObject private var presenter: TodoPresenter

    init(presenter: TodoPresenter) {
        self._presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter new todo item", text: $presenter.todoItemTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: presenter.addTodoItem) {
                    Text("Add")
                }
                .padding()

                List {
                    ForEach(presenter.todoItems) { todoItem in
                        Button(action: { presenter.toggleTodoItem(todoItem: todoItem) }) {
                            HStack {
                                Text(todoItem.title)
                                Spacer()
                                if todoItem.completed {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Todo List")
        }
    }
}
