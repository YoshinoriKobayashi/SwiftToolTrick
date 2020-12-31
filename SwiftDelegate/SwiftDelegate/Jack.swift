//
//  Jack.swift
//  SwiftDelegate
//
//  Created by yoshiiikoba on 2020/09/11.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

// 処理を任される側
import Foundation

// デリゲートメソッドの具体的な処理内容を実装 
final class Jack: greetingDelegate {
    func sayHello() {
        print("Hello!")
    }
    func sayName() {
        print("My Name is Jack")
    }
    func sayAge() {
        // デフォルト実装を上書き
        print("My age is 25")
    }
}
