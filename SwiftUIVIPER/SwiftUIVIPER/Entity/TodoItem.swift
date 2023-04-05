//
//  Entity.swift
//  SwiftUIVIPER
//
//  Created by Yoshinori Kobayashi on 2023/04/05.
//

// Entityは、アプリケーションで使用されるデータモデルを表します。
// SwiftUIでは、Entityは普通のSwiftの構造体として実装されます。
struct TodoItem: Identifiable {
    var id: Int
    var title: String
    var completed: Bool
}

