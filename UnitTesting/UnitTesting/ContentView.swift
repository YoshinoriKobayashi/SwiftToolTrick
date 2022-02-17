//
//  ContentView.swift
//  UnitTesting
//
//  Created by yoshiiikoba on 2022/02/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    // iOSテスト全書 P48
    // リスト3.1 パスワードバリデーションのテスト対象のコード
    static func validate(password: String) -> Bool {
        if password.count <= 7 {
            return false
        }
        // components：文字列分割
        // CharacterSet： Unicodeに準拠した文字の集合を表します。ファンデーションタイプは `CharacterSet` を使って、検索操作のために文字をグループ化し、検索中に特定の文字セットのどれかを見つけることができるようにします。
        // decomposables：Unicode 文字エンコーディング規格のバージョン 3.2 における "標準的な分解" の定義により、合成文字シーケンスとしても表現可能な個々の Unicode 文字を含む文字セットを返します。
        // inverted
        let numString = password.components(separatedBy: CharacterSet.decomposables.inverted).joined()
        return numString.count >= 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
