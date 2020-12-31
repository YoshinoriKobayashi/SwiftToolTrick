//
//  Protocol.swift
//  SwiftDelegate
//
//  Created by yoshiiikoba on 2020/09/11.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

// delegate で使用するメソッドやパウロパティを定義
protocol greetingDelegate {
    func sayHello()
    func sayName()
    func sayAge()
}

extension greetingDelegate {
    // デフォルト実装
    // プロトコル適合先で実装しなくてもエラーにならない
    func sayAge() {
        print("My age in 10")
    }
}
