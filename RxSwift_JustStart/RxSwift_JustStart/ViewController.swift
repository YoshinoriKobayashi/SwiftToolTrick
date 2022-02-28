//
//  ViewController.swift
//  RxSwift_JustStart
//
//  Created by kobayashi on 2022/02/28.
//

import UIKit
import RxSwift
import RxCocoa

enum MyError: Error {
    case error
}

class ViewController: UIViewController {

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        // ====== just(1)でデータ型<Int>、Observable<Int>に変わる
//        let _ = Observable.just(1).debug("just(1)").subscribe(
//            onNext: { event in
//                print(event)
//            }
//        )
//
//        // ====== Observable.from() を使うと、配列の各要素をObservableでラップしてくれ、subscribeで順番になめるということができます。
//        let _ = Observable.from(0...10).debug("from(0...10)").subscribe (
//            onNext: { event in
//                print(event)
//            }
//        )
//
//        // エラーが発生するObservable
//        let _ = Observable.error(MyError.error).debug("MyError.error").subscribe(
//            onNext: { event in
//                print(event)
//            },
//            onError: { error in
//                print("エラー! \(error)")
//
//            }
//        )
        
//        // 配列の要素の中にエラーを混入させてみる
//        // create：指定された subscribe メソッドの実装から observable シーケンスを作成します。
//        Observable<Any>.create { observer in
//             print("===Observable.create start")
//            // このクロージャの中で実行するシーケンスを作成する
//            // 入力値としてobserverがくる。このobserverをカスタマイズする感じ
//            [1,2,3,4].forEach({
//                // on：このオブザーバに `event` を送信する。
//                // next：シーケンスイベントを表す、次のエレメントを生成します。
//                observer.on(.next($0))
//            })
//
//            // error：エラーが発生し、シーケンスが終了した。
//            observer.on(.error(MyError.error))
//            //
//            print("===Observable.create end")
//            return Disposables.create()
//
//        }.debug("Observable<Any>.create").subscribe(
//            onNext: { event in
//                print("subscribe:onNext:",event)
//            },
//            onError: { error in
//                print("subscribe:エラー！\(error)")
//            }
//        )
        
        // ==== RxCocoaでのバインディング
        tableView.delegate = nil
        tableView.dataSource = nil
        let items = Observable<[String]>.just((0..<20).map { "\($0)" })
        
        // UITableViewとのバインディングの書き方が複数ある
        // https://qiita.com/hironytic/items/71bc729abe73ab9f0879
        // 書き方パータン１
        // 最もシンプルなのがこのパターン
        // rx.items の第1引数にidentifierを渡す。
        // クロージャーの中で、セルに値をセットする。
        items.bind(to: tableView.rx.items(cellIdentifier: "cell")) { row, element, cell in
            // ここでセルの中身を設定する
            cell.textLabel?.text = "\(element)"
        }
        .disposed(by: disposeBag)
    }

    @IBOutlet weak var tableView: UITableView!
    
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//        cell.textLabel?.text = "RxSwift"
//        return cell
//    }
}

