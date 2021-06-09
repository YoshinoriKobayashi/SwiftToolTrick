//
//  SafariView.swift
//  MyOkashiCustom
//
//  Created by Swift-Beginners on 2021/06/09.
//

import SwiftUI
import SafariServices

// SFSafariViewControllerを起動する構造体
struct SafariView: UIViewControllerRepresentable {
    // 表示するホームページのURLを受ける変数
    var url: URL

    // 表示するViewを生成するときに実行
    func makeUIViewController(context: Context) -> some UIViewController {
        // Safariを起動
        return SFSafariViewController(url: url)
    }

    // Viewが更新されたときに実行
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // 処理なり
    }
}
