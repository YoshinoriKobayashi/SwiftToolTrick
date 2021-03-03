//
//  ViewController.swift
//  RxSwiftCountApp
//
//  Created by Swift-Beginners on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {

    // VieModelの宣言
    private var ViewModel: CounterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // インスタンス化
        ViewModel = CounterViewModel()
    }

    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBAction func countUp(_ sender: Any) {
        ViewModel.incrementCount(callback: { [weak self] count in self?.updateCountLabel(count)})
    }
    
    @IBAction func countDown(_ sender: Any) {
        ViewModel.decrementCount(callback: { [weak self] count in self?.updateCountLabel(count)})
    }
    
    @IBAction func countReset(_ sender: Any) {
        ViewModel.resetCount(callback: { [weak self] count in self?.updateCountLabel(count)})
    }
    
    private func updateCountLabel(_ count: Int) {
        countLabel.text = String(count)
    }
}

class CounterViewModel {
    // ViewModel
    // ・カウントデータの保持
    // ・カウントアップ
    // ・カウントダウン
    // ・カウントリセット
    
    private(set) var count = 0
    
    // クロージャでコールバック
    // コールバックで書くメリット
    // 記述が簡単
    // コールバックで書くデメリット
    // ・ボタンを増やすたびに対応するボタンの処理メソッドが増えていく
    // ・ラベルの場合も同様
    // ・画面が大きくなっていくにつれてメソッドが多くなり、コードが読みづらくなってくる
    // ViewControllerとViewModelに分けたものの、完全にUIと処理の切り分けができているわけではない
    func incrementCount(callback: (Int) -> ()) {
        count += 1
        callback(count)
    }
    
    func decrementCount(callback: (Int) -> ()) {
        count -= 1
        callback(count)
    }
    
    func resetCount(callback:(Int) -> ()) {
        count = 0
        callback(count)
    }
    
}

// Delegateの作成
protocol CounterDelegagte {
    func updateCount(count: Int)
}
