//
//  ContentView.swift
//  SwiftUIListDelete
//
//  Created by yoshiiikoba on 2021/09/26.
//

import SwiftUI

struct ContentView: View {
    /// ①対象のコレクション（配列）が更新可能
    @State private var fruits = ["りんご", "オレンジ", "バナナ", "パイナップル", "いちご"]
    
    var body: some View {
        /// ②List+ForEachでリストを生成
        List {
            /// ③id指定による繰り返し
            ForEach(fruits, id: \.self) { fruit in
                Text(fruit)
            }
            /// 行削除操作時に呼び出す処理の指定
            .onDelete(perform: rowRemove)
        }
    }
    
    /// 行削除処理
    func rowRemove(offsets: IndexSet) {
        fruits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
