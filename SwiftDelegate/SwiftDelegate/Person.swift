//
//  Person.swift
//  SwiftDelegate
//
//  Created by yoshiiikoba on 2020/09/11.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import Foundation

// 処理を任せる側のクラス
// 処理を任せる側のクラスでは、どの条件でどんな処理をするのかといった処理の流れを記述
// メソッドの具体的な処理内容は記述しない
// finalで継承されるのを禁止、継承されない最後のクラス
final class Person {
    
    // 処理を任せる相手を保持する
    weak var delegate: greetingDelegate?
    
    // 値型はスクープの範囲外で自動的にメモリが開放
    // 参照型は、ARCで管理。参照カウントが0でメモリ解放
    // 強参照:strong   参照カウントが1増加、循環参照は参照し合うためにカウントが0にならずメモリが開放されない
    // 弱参照:weak     参照カウント変化なし
    // 非所有参照:unowned
    
    
    func greet() {
        guard let delegate = delegate else {
            // 処理を任せる相手が決まっていない場合
            print("No Person")
            return
        }
        if type(of: delegate) == John.self {
            // 処理を任せる相手がJohnクラスの場合
            // 挨拶と名前をログに出力
            delegate.sayHello()
            delegate.sayName()
        } else if type(of:delegate) == Jack.self {
            // 処理を任せる相手がJackクラスの場合
            // 挨拶と名前と年齢をログに出力
            delegate.sayHello()
            delegate.sayName()
            delegate.sayAge()
            // ここでは処理する流れだけで、処理の内容はない
            // 処理の内容が変更になってもこのclassには影響はない。
        }
    }
}
