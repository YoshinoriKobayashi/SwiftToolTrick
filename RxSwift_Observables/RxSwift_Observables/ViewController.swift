//
//  ViewController.swift
//  RxSwift_Observables
//
//  Created by kobayashi on 2022/03/02.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        let one = 1
//        let two = 2
//        let three = 3
        
//        // 定数を1つにして、justメソッドでInt型の観測可能なシーケンスを作成しなさい。
//        // observableは、Observable<Int> 型になる
//        let observable = Observable<Int>.just(one)
//
//        // of:このメソッドは、可変の要素数を持つ新しいObservableインスタンスを作成します。
//        // observable2は、Observable<Int> 型になる
//        let observable2 = Observable.of(one, two, three)
//
//        // just演算子は配列を1つの要素として取る
//        // observable3は、Observable<[Int]> 型になる
//        // of は配列がそのまま使う
//        let observable3 = Observable.of([one, two, three])
//
//        // observable4は、Observable<Int> 型になる
//        // from は配列を取る
//        let observable4 = Observable.from([one, two, three])
        
//        // ==============================
//        // observable3は、Observable<Int> 型になる
//        // Observable（観測可能）なデータ型のInt
//        let observable = Observable.of(one, two, three)
     
//        // イベントの購読を開始
//        // ジェネリクスによりEvent<Int>でInt型を受け取ることがわかる
//        observable.subscribe { event in
//            print("event.element:", event.element)
//            // elementはオプショナルな値。
//            // 値を取り出す
//            if let element = event.element {
//                print(element)
//            }
//        }
//        // ショートハンド
//        // 要素の取り出しをしなくてもそのまま使える
//        observable.subscribe(onNext: { element in
//            print(element)
//        })
        
        // ==============================
//        let observable = Observable<Void>.empty()
//
//        observable.subscribe(
//            // 次のイベントを処理します。
//            onNext: {
//                element in
//                 print(element)
//            },
//            // .completed イベントは要素を含まないので、単にメッセージを表示するだけです。
//            onCompleted: {
//                print("Completed")
//            }
//        )
        
        // ==============================
        
//        let observable = Observable<Void>.never()
//
//        observable.subscribe(
//            onNext: { element in
//                print(element)
//            }, onCompleted: {
//                print("Completed")
//            }
//        )
    
//        // ==============================
//        // 開始整数値と生成する連続した整数のカウントを取る range 演算子
//        let observable = Observable<Int>.range(start: 1, count: 10)
//
//        observable
//            .subscribe(onNext: { i in
//
//                let n = Double(i)
//                // 放出された各要素についてn番目のフィボナッチ数を計算
//                let fibonacci = Int(
//                    ((pow(1.61803, n) - pow(0.61803, n)) / 2.23605).rounded()
//                )
//                print(fibonacci)
//            })
        
        // ==============================
        
//        let observable = Observable.of("A","B","C")
//
//        let subscription = observable.subscribe { event in
//            print(event)
//        }
//
//        subscription.dispose()
        
        // ==============================
        
//        let disposeBag = DisposeBag()
//
//        Observable.of("A","B","C")
//            .subscribe {
//                print($0)
//            }
//            .disposed(by: disposeBag)
        
//        enum MyError: Error {
//            case anError
//        }
//        let disposebag = DisposeBag()
//
//        Observable<String>.create { observer in
//
//             // onNext(_:) は on(.next(_:)) の便宜的なメソッド
//            observer.onNext("1")
////            observer.onError(MyError.anError)
//            // 完了イベントをオブザーバーに追加。onCompleted は on(.completed) の便宜的なメソッド
////            observer.onCompleted()
//            // 別の next イベントをオブザーバに追加
//            observer.onNext("?")
//            // observable が終了したとき破棄
//            return Disposables.create()
//        }
//        .subscribe(
//            onNext: { print($0)}, onError: { print($0)}, onCompleted: { print("Completed")}, onDisposed: { print("Disposed")}
//        )
////        .disposed(by: disposebag)
        
        
        // ==============================
        
        let disposeBag = DisposeBag()
        
        // どのobservableを返すかを反転させるBoolフラグ
        var flip = false
        
        // deferred（デファード：遅延演算子）を使って、Int factoryの observable を作成
        let factory: Observable<Int> = Observable.deferred {
            //
            flip.toggle()
            
            // 異なるobservableを返します。
            if flip {
                return Observable.of(1,2,3)
            } else {
                return Observable.of(4,5,6)
            }
        }
        
        for _ in 0...3 {
            factory.subscribe(onNext: {
                print($0, terminator: "")
            })
                .disposed(by: disposeBag)
            
            print()
        }
    }
}

