//
//  ContentView.swift
//  MyOkashiCustom
//
//  Created by Swift-Beginners on 2021/06/05.
//

import SwiftUI

struct ContentView: View {

    // OkashiDataを参照する状態変数
    // 複数データを外部と共有する
    // ObservedObject
    @ObservedObject var okashiDataList = OkashiData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    // SafariViewの表示有無を管理する変数
    @State var showSafari = false

    var body: some View {
        // 垂直にレイアウト（縦方向にレイアウト）
        VStack {
            // 文字を受け取るTextFieldを表示する
            TextField("キーワードを入力してください", text: $inputText,onCommit: {
                // 入力完了直後に検索をする
                okashiDataList.searchOkashi(keyword: inputText)
            })
            .padding()
            // リスト表示する
            List(okashiDataList.okashiList) { okashi in
                // １つ１つ要素が取り出される
                // ボタンを用意する
                Button(action: {
                    // SafariViewを表示する
                    showSafari.toggle()
                }) {
                    // okashiに要素を取り出して、List（一覧）を生成する
                    // 水平にレイアウト（横方向にレイアウト）
                    HStack {
                        // 画像を表示する
                        Image(uiImage: okashi.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:40)
                        // テキスト表示する
                        Text(okashi.name)
                    }
                }//
                .sheet(isPresented: self.$showSafari, content: {
                    // SafariViewを表示する
                    SafariView(url: okashi.link)
                        // 画面下部をいっぱになるようにセーフエリア外までいっぱいになるように指定
                        .edgesIgnoringSafeArea(.bottom)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
