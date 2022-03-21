//
//  ViewController.swift
//  RxSwift_Playground
//
//  Created by kobayashi on 2022/03/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // ここにRxSwiftのコードを書く
//        _ = Observable.just(10)
//            .map{ $0 * 2} // 2倍にする
//            .subscribe(onNext: {
//                    print($0)  //
//            })
        
//        _ = Observable.just(10)
//            .map{(arg: Int) -> String in  // この戻り値によってデータ型が変わる
//                return "value: \(arg)"
//            }
//            .subscribe(onNext: {(arg: String) -> Void in
//                print(arg) //
//            })
        
        // ObservableとObserverの両方を持つ
        let subject = PublishSubject<String>()
        
        subject.subscribe(onNext: {
            print("onNext:", $0)
        })
        
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("C")
        subject.onNext("D")
        subject.onCompleted()
        
    }


}

