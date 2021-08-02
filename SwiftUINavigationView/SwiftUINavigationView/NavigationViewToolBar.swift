//
//  NavigationViewToolBar.swift
//  SwiftUINavigationView
//
//  Created by Swift-Beginners on 2021/07/24.
//

import SwiftUI

struct NavigationViewToolBar: View {
    var body: some View {
        NavigationView {
            List(1..<20) { index in
                NavigationLink(
                    destination: Text("\(index)番目のView")) {
                        Text("\(index)行目")
                }
            }
            .navigationTitle("NavigationView")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                // placementで場所を指定
                /// ナビゲーション左
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "magifyingglass")
                    }
                }
                /// ナビゲーション右１
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "trash")
                    }
                }
                /// ナビゲーション右２
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {}
                }
                /// ボトムバー
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {}) {
                        Label("送信",systemImage: "paperplane")
                    }
                    Spacer()
                    Button(action: {}) {
                        Label("送信",systemImage: "paperplane")
                    }
                    Spacer()
                    Button(action: {}) {
                        Label("送信",systemImage: "paperplane")
                    }
                }
            }
        }
    }
}

struct NavigationViewToolBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewToolBar()
    }
}
