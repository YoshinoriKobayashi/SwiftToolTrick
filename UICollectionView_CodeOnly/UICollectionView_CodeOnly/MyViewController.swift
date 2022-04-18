//
//  ViewController.swift
//  UICollectionView_CodeOnly
//
//  Created by kobayashi on 2022/04/12.
//

import UIKit

// まずは、ViewControllerにcollectionViewを生成していきます。
//スクリーンサイズの取得
let screenSize: CGSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

class MyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    private let collectionView: UICollectionView = {
        // セルのレイアウト設計
        // UICollectionViewFlowLayoutはビルトインで用意されている
        // UICollectionViewのレイアウトオブジェクト
        // UICollectionViewのレイアウトはデフォルトで
        // UICollectionViewFlowLayoutが使用されます。
        // UICollectionViewFlowLayoutはセルの大きさやセル同士の間隔、
        // セクションごとの余白の大きさなどを設定するプロパティを持っており、
        // これらを変更することでレイアウトを変更することができます。
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        //各々の設計に合わせて調整

        // グリッドレイアウトは、水平または垂直のどちらかの軸にのみスクロールします。
        // 非スクロール軸の場合、その次元のコレクションビューの幅がコンテンツの開始幅として機能します。
        layout.scrollDirection = .vertical
        // 同じ行の項目間で使用する最小間隔。
        layout.minimumInteritemSpacing = 0
        // グリッド内の項目の行間に使用する最小の間隔を指定します。
        layout.minimumLineSpacing = 0

        // 指定されたフレームとレイアウトを持つコレクションビューオブジェクトを作成します。
        // frame:コレクションビューのフレーム矩形で、
        // 単位はポイントです。フレームの原点は、
        // それを追加する予定のスーパービューからの相対的なものです。
        // このフレームは、初期化中にスーパークラスに渡されます。
        // layout:項目を整理するために使用するレイアウトオブジェクト。コ
        // レクションビューは、指定されたオブジェクトへの強い参照を保存します。nilであってはならない。
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        // セルの登録
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView

    }()


    fileprivate let fruits: [String] = ["apple", "grape", "lemon", "banana", "cherry", "strobery", "peach", "orange"]

    override func viewDidLoad() {
        super.viewDidLoad()

        //生成したcollectionViewのdataSourceとdelegteを紐づける
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
    }

    //cellの個数設定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fruits.count
    }

    // データソースオブジェクトに、コレクションビューの指定された項目に対応するセルを問い合わせる。
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        let cellText = fruits[indexPath.item]
        cell.setupContents(textName: cellText)
        return cell
    }

}

//cellのサイズの設定
extension MyViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      //ここでは画面の横サイズの半分の大きさのcellサイズを指定
      return CGSize(width: screenSize.width / 2.0, height: screenSize.width / 2.0)
  }
}
