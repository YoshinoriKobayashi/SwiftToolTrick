//
//  John.swift
//  SwiftDelegate
//
//  Created by yoshiiikoba on 2020/09/11.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import Foundation

// 処理を任される側
// デリゲートメソッドの具体的な処理内容を実装
final class John: greetingDelegate {
    func sayHello() {
        print("Hello!")
    }
    func sayName() {
        print("My name is John")
    }
}
