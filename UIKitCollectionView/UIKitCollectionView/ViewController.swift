//
//  ViewController.swift
//  UIKitCollectionView
//
//  Created by kobayashi on 2022/04/12.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // レイアウトを調整
        // 「UICollectionViewDelegateFlowLayout」をViewControllerの拡張に追加
        // (UICollectionViewDelegateの後ろに追記)して、セルの大きさや隙間を調整するソースを書きます。
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout

    }

    // 指定されたセクションの項目数をデータソースオブジェクトに問い合わせる
    func collectionView(_ collectView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18 // 表示するセルの数
    }

    // cellForItemAt:データソースオブジェクトに、コレクションビューの指定された項目に対応するセルを問い合わせる。
    func collectionView(_ collectView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 表示するセルを登録(先程命名した"Cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // セルの色
        cell.backgroundColor = UIColor.red
        return cell
    }
    // collectionView(_:layout:sizeForItemAt:)
    // 指定された項目のセルの大きさをデリゲートに問い合わせます。
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Cellの大きさや隙間を調整
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}

