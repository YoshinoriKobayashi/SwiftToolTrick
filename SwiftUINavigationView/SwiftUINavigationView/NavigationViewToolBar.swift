//
//  NavigationViewToolBar.swift
//  SwiftUINavigationView
//
//  Created by Swift-Beginners on 2021/07/24.
//

import SwiftUI

struct NavigationViewToolBar: View {
    
    init() {
        let backgroundColor = UIColor(red: 73/255, green: 119/255, blue: 172/255, alpha: 1.0)
        // ナビゲーションバーはSwiftUIの配色は実現できない
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()     
            //ナビゲーションバーの背景を変更
            appearance.backgroundColor = backgroundColor
            //ナビゲーションのタイトル文字列の色を変更
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            // ナビゲーションバーに反映
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            //ナビゲーションアイテムの色を変更
            UINavigationBar.appearance().tintColor = UIColor.white
            
        } else {
            // iOS14以前
            //ナビゲーションバーの背景を変更
            UINavigationBar.appearance().barTintColor = backgroundColor
            //ナビゲーションのタイトル文字列の色を変更
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            //ナビゲーションアイテムの色を変更→accentColorで設定できるので不要
            // UINavigationBar.appearance().tintColor = UIColor.white
                    
        }
        
        // ツールバーだけど、bttomの色しか変化しない？？
        UIToolbar.appearance().barTintColor = UIColor.red
        

    }
    var body: some View {
        NavigationView {
            List(1..<20) { index in
                NavigationLink(
                    destination: Text("\(index)番目のView")) {
                        Text("\(index)行目")
                }
            }
            .navigationTitle("ナビゲーションタイトル")
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
        .accentColor(.white) // iOS14から対応している。
        // https://stackoverflow.com/questions/64467504/how-to-change-color-of-toolbaritem-with-navigationbarleading-placement-in-swiftu
    }
}

struct NavigationViewToolBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewToolBar()
    }
}
