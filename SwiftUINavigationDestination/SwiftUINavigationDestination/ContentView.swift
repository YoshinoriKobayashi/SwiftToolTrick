//
//  ContentView.swift
//  SwiftUINavigationDestination
//
//  Created by Yoshinori Kobayashi on 2023/04/07.
//

import SwiftUI

struct ContentView: View {
    // この配列を使用して現在のViewのスタック状況が把握できます。
    // また、NavigationLinkを使わずとも、配列の操作によってスタックの内容の変更が可能となります。
    /// ナビゲーションパス（Viewの重なり状況）を管理する配列
    @State private var colors: [Color] = []


    var body: some View {
        /// ナビゲーションの定義
        /// NavigationStack配下での画面遷移は、実際には現在のViewの上に遷移先のViewを重ねていく動作によって実現しています。
        /// ナビゲーショのパスとしてカラーを指定
        NavigationStack(path: $colors) {
            List {
                /// 画面遷移リンクの定義（遷移先を示す値としてColorを指定）
                NavigationLink("Mint", value: Color.mint)
                NavigationLink("Pink", value: Color.pink)
                NavigationLink("Teal", value: Color.teal)
                
                /// Blue画面への遷移ボタン
                Button("Blue") {
                    colors.append(.blue)    // ナビゲーションパスにデータを追加
                }
                /// 2色まとめて遷移するボタン
                Button("Orange + Green") {
                    colors += [.orange, .green] // ナビゲーションパスにデータを2件追加
                }
            }
            /// 遷移先を示すデータとしてColor型が指定されたときの遷移先定義
            /// データ型と遷移先の関連付けは、次のイニシャライザで行います。
            /// データ型には"型名.self"を指定します。
            ///  .navigationDestination(for: データ型, destination:() -> 遷移先View)
            .navigationDestination(for: Color.self) { color in
                /// 色詳細Viewに遷移
                /// ここでNavigationLinkで指定したデータがわたってくる。colorがそれ
                ColorDetail(color: color)
            }
            .navigationBarTitle("Colors")   // ナビゲーションタイトルの定義
        }
    }
}

// 色詳細View
// 引数で指定された色を表示するView
struct ColorDetail: View {
    var color: Color  /// ここにデータが渡ってくる
    
    var body: some View {
        color  // カラーで塗る
            .navigationTitle(color.description) // タイトルに色名を指定
    }
}
