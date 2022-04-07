//
//  PageViewController.swift
//  UIKitPageViewController
//
//  Created by kobayashi on 2022/04/07.
//

import UIKit

class PageViewController: UIPageViewController {

    // ①PageViewで表示するViewControllerを格納する配列を定義
    // PageViewControllerでは、表示するViewControllerを配列で管理するため、クラス内グローバル関数を定義します。

    private var controllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initPageViewController()

    }

    // PageViewControllerの初期化処理
    private func initPageViewController() {

        // ②PageViewControllerで表示するViewControllerをインスタンス化する
        // 次は、表示対象のViewControllerをインスタンス化します。
        let firstVC = storyboard!.instantiateViewController(withIdentifier: "FirstView")
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "SecondView")
        let thirdVC = storyboard!.instantiateViewController(withIdentifier: "ThirdView") 

        // ③インスタンス化したViewControllerを配列に保存する
        // 次に、最初に定義した配列にインスタンス化したViewControllerを格納します。
        // この時、表示順に格納していくのがポイントです。インデックスのインクリメント、デクリメントで表示を切り替えるためです。
        self.controllers = [firstVC, secondVC , thirdVC]

        // ④最初に表示するViewControllerを指定する
        // 次は、最初に表示する画面を設定します。設定するプロパティは[ setViewControllers ]です。
        //
        // 第一引数：　最初に表示するViewController
        // 第二引数：　ナビゲーションの指定
        // 第三引数：　アニメーション有無
        // 第四引数：　コールバック関数
        // 詳しくは公式ドキュメントを確認してください。
        // setViewControllers(_:direction:animated:completion:)
        setViewControllers([controllers[0]], direction: .forward, animated: true,completion: nil)

        // ⑤PageViewControllerのDataSourceを関連付ける
        // 最後に、PageViewControllerのDataSourceを関連付けます。
        self.dataSource = self
    }
}

// ⑥pageViewControllerのDataSourceを定義
// MARK: -UIPageViewController DataSource
 // DataSourceでやっていることは、ページ数の上限設定、左右スワイプの挙動になります。
extension PageViewController: UIPageViewControllerDataSource {
    //　ページ数
     // ページ数の上限は[ presentationCount ]で行います。配列のインデックス数を指定してあげればOKです。
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }

    // 左にスワイプ（進む）
    // 左スワイプの挙動は[ pageViewController(viewControllerAfter) ]で行います。引数内にAfterが付いている関数です。
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),index < self.controllers.count - 1 {
            return self.controllers[index + 1]
        } else {
            return nil
        }
    }

    /// 右にスワイプ（戻る）
    /// // 右スワイプの挙動は[ pageViewController(viewControllerBefore) ]で行います。引数内にBeforeが付いている関数です。
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController), index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }

//    やっていることは単純です。
//    左スワイプ検知時、最初に定義した配列での現在表示しているViewControllerのインデックスを取得し、上限値を超過していなければ、次ページのインデックスを渡しています。
//    右スワイプ検知時は、同じく表示中のViewControllerのインデックスを取得し、0未満(最初のページ)ではない時に、前ページのインデックスを渡してます

}
