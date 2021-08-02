//
//  NavigationView.swift
//  SwiftUINavigationView
//
//  Created by Swift-Beginners on 2021/07/24.
//

import SwiftUI

struct NavigationViewNormal: View {
    var body: some View {
        // NavigationViewを有効にするには、階層のトップ画面でNavigationViewを使用します。
        NavigationView {
            // ここに記述されたViewがNaigation管理配下になる
            // ここのViewはなんでもいい
            List(1..<20) { index in
                NavigationLink(
                    destination: Text("\(index)番目のView")) {
                    Text("\(index)行目")
                }
            }
            // Navigation配下のViewにタイトルを指定
            .navigationTitle("Top View")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavigationViewNormal_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewNormal()
    }
}
