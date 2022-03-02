//
//  ViewController.swift
//  RxSwift_subject
//
//  Created by kobayashi on 2022/03/01.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        /// PublishSubject
        //        /// 観察可能なシーケンスであり、かつ観察者でもあるオブジェクトを表す。
        //        /// 各通知は、購読しているすべてのオブザーバーにブロードキャストされます。
        //        let subject = PublishSubject<String>()
        //
        //        // 購読しているすべてのオブザーバに、次のイベントを通知する。
        //        subject.on(.next("Is anyone listening?"))
        //
        //        // イベントを通知したあとで、購読（subscribe）しても受信できない
        //        let subscriptionOne = subject
        //          .subscribe(onNext: { string in
        //            print(string)
        //          })
        //
        //        // 購読したあとなら受信できる
        //        subject.on(.next("1"))
        //
        //        // .on(.next("1"))を省略してかける
        //        // このメソッドの中では、「self.on(.next(element))」が定義されている
        //        subject.onNext("2")
        //
        //        // ここでの購読前にイベント発行しても受信できない
        //        let subscriptionTwo = subject
        //          .subscribe { event in
        //            print("2)", event.element ?? event)
        //          }
        //
        //        // 3は、subscriptionOneとsubscriptionTwoの2回printされます。
        //        subject.onNext("3")
        //
        //        // subscriptionOneを終了させる
        //        subscriptionOne.dispose()
        //
        //        // subscriptionTwo でしか受信しない
        //        subject.onNext("4")
        //
        //        // on(.completed)
        //        //　便利なメソッドを使用して、completedイベントをsubjectに追加します。
        //        //　これによって、subjectの観測可能なシーケンスが終了します。
        //        subject.onCompleted()
        //        // subjectに別の要素を追加します。
        //        // しかし、subjectはすでに終了しているため、これは発行・printされません。
        //        subject.onNext("5")
        //        // subscriptionを破棄します。
        //        subscriptionTwo.dispose()
        //        let disposeBag = DisposeBag()
        //
        //        // Subscribeして、今度は使い捨てのバッグを追加します。
        //        subject
        //          .subscribe {
        //            print("3)", $0.element ?? $0)
        //          }
        //          .disposed(by: disposeBag) // disposedは使い捨てのような意味
        //
        //        // subjectは使い捨てで存在していないので受信できない
        //        subject.onNext("?")
        //
        // 1
        enum MyError: Error {
            case anError
        }
//
//        // 3
//        // 新しいBehaviorSubjectのインスタンスを作成します。
//        // そのイニシャライザーは初期値を取ります。
//        let subject = BehaviorSubject(value: "Initial value")
//        let disposeBag = DisposeBag()
//
//        // こいつがあるときは２つ目のイベントになるので、これが①で出力される
//        subject.onNext("X")
//
//        // サブジェクトが作成された直後にサブスクライブします。
//        // サブジェクトには他の要素が追加されていないため、
//        // サブスクライバにその初期値が再生されます。
//        subject
//            .subscribe {
//                print("1)", $0) // ①
//            }
//            .disposed(by: disposeBag)
//
//        // 1
//        subject.onError(MyError.anError)
//
//        // 2
//        subject
//          .subscribe {
//            print("2)", $0)
//          }
//          .disposed(by: disposeBag)
        
        // ==========================
        
//        // バッファサイズ2のReplay subjectsを新規に作成する。Replay subjectsは型メソッドcreate(bufferSize:)で初期化する。
//        let subject = ReplaySubject<String>.create(bufferSize: 2)
//        let disposeBag = DisposeBag()
//
//        // subjectに3つの要素を追加します。
//        subject.onNext("1")
//        subject.onNext("2")
//        subject.onNext("3")
//
//        // subjectに 2 つのサブスクリプションを作成します。
//        subject
//            .subscribe{
//                print("1)", $0)
//            }
//            .disposed(by: disposeBag)
//
//        subject
//            .subscribe {
//                print("2)", $0)
//            }
//            .disposed(by: disposeBag)
//
//        subject.onNext("4")
//
//        subject.onError(MyError.anError)
//
//        // ここではdisposeしない、disposedで自動的に割り当てが解除される
//        // subject.dispose()
//
//        // バッファリングされた最後の 2 つの要素を再生して受け取ります
//        subject.subscribe {
//                print("3)", $0)
//        }
//        .disposed(by: disposeBag)
        // ==========================
        

//        // PublishRelayはPublishSubjectをラップし、BehaviorRelayはBehaviorSubjectをラップしています
//        // リレーがラップされたサブジェクトと異なるのは、
//        // リレーは決して終了しないことが保証されていることです。
//        let relay = PublishRelay<String>()
//        let disposeBag = DisposeBag()
//
//        // Publishリレーに新しい値を追加するためには
//        // accept(_:)メソッドを使用します。
//        // onNextは使わない
//        // このメソッドの中では「self.subject.onNext(event)」を使っている
//        relay.accept("Knock knock, anyone home?")
//
//        relay
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposed(by: disposeBag)
//
//        relay.accept("1")
//
//        // エラーは指定できない
////        relay.accept(MyError.anError)
        
        
        // ==========================
        
        // 初期値を持つBehaviorRelayを作成します。
        // リレーの型は推論されますが、
        // 明示的にBehaviorRelay<String>(value: "Initial value")と宣言することも可能です。
        let relay = BehaviorRelay(value: "Initial value")
        let disposeBag = DisposeBag()
        
        // リレーに新しい要素を追加する。
        relay.accept("New initial value")
        
        relay
            .subscribe {
                print("1)", $0)
            }
            .disposed(by: disposeBag)
        
        // リレーに新しいエレメントを追加する。
        relay.accept("1")
        
        // リレーに新しいサブスクリプションを作成する。
        relay
            .subscribe {
                print("2)", $0)
            }
            .disposed(by: disposeBag)
        
        // リレーに別の新しい要素を追加する
        relay.accept("2")
        
        print(relay.value)
    }
    
    
    
}

