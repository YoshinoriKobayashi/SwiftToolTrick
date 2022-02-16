//
//  ViewModel.swift
//  SwiftUIRxSwift
//
//  Created by kobayashi on 2022/02/16.
//

import Foundation
import RxSwift

class ViewModel: ObservableObject {
    @Published var text: String = ""
    func print() {
        Swift.print("テスト")
    }
    
    init() {
        // グローバルな同時ディスパッチキューの一つをラップした `SerialDispatchQueueScheduler` を新規に作成します。
        // qos: 指定された QoS クラスを持つグローバルディスパッチキューの識別子。
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        // 指定されたスケジューラを使ってタイマを実行し、オブザーバ・メッセージを送信し、
        // 各期間の後に値を生成する観測可能なシーケンスを返す
        let subscription = Observable<Int>.interval(.milliseconds(300), scheduler: scheduler)
            // イベントハンドラを観測可能なシーケンスにサブスクライブします。
            .subscribe { event in
                //
                Swift.print(event)
            }

        // 2秒とめる
        Thread.sleep(forTimeInterval: 2.0)
        // リソースを破棄する。
        subscription.dispose()
    }
    
}
