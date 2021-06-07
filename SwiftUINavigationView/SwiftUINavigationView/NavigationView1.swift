//
//  NavigationView1.swift
//  SwiftUINavigationView
//
//  Created by Swift-Beginners on 2021/06/04.
//

import SwiftUI

struct NavigationView1: View {
    var body: some View {
        NavigationView {
            // NavigationViewに関するModifierはNavigationViewそのものではなく、Navigation配下のViewに適用します。
            // ここに記述されたViewがナビゲーション管理配下となる
            List(1..<20) {
                index in
                // 画面の遷移先の指定
                NavigationLink(
                    // 引数destinationに遷移先Viewを指定
                    destination: Text("\(index)番目のView")) {
                    Text("\(index)行目")
                }
            }
            .navigationTitle("Top View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavigationView1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView1()
    }
}
