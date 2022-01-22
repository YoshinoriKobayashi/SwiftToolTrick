//
//  ContentView.swift
//  ListApp
//
//  Created by yoshiiikoba on 2021/11/11.
//

import SwiftUI

// フルーツを格納する型（構造体）
private struct Fruits: Identifiable {
    let name: String
    let id = UUID()
}
// データを格納
private let fruits = [
    Fruits(name: "🍎りんご"),
    Fruits(name: "🍊オレンジ"),
    Fruits(name: "🍋レモン"),
    Fruits(name: "🍓いちご")
]

struct ContentView: View {
    // 選択されたリストのIDを格納する
    @State private var multiSelection = Set<UUID>()

    var body: some View {
        NavigationView {
            List(fruits, selection: $multiSelection) { oneFruits in
                Text(oneFruits.name)
            } // List ここまで
            .navigationTitle("フルーツ")
            .toolbar{ EditButton() }
        }
    }
}

//// データを格納
//struct ContentView: View {
//    var body: some View {
//        List {
//            Text("🍎りんご")
//            Text("🍊オレンジ")
//            Text("🍋レモン")
//            Text("🍓いちご")
//            Text("🥝キューイ")
//            Text("🍇ぶどう")
//        } // List ここまで
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
