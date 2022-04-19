//
//  ViewController.swift
//  AnimalPeekABoo
//
//  Created by Yuichi Fujiki on 12/2/18.
//  Copyright © 2018 Yuichi Fujiki. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var frameImageView: UIImageView!

    @IBOutlet weak var frameImageViewAspectRatioConstraintLandscape: NSLayoutConstraint!

    @IBOutlet weak var frameImageViewAspectRatioConstraintPortrait: NSLayoutConstraint!

    @IBOutlet weak var frameImageViewLeftConstraint: NSLayoutConstraint!

    @IBOutlet weak var frameImageViewTopConstraint: NSLayoutConstraint!

    private var scrollViewSize: CGSize = .zero

    private var images = [UIImage]()

    private var dragging = false

    // スクロールを考慮した画像
    lazy private var imageViews: [UIImageView] = {
        let imageViews = [
            UIImageView(frame: .zero),
            UIImageView(frame: .zero),
            UIImageView(frame: .zero)
        ]
        imageViews.forEach({ imageView in
            imageView.contentMode = .scaleAspectFit
        })
        return imageViews
    }()

    lazy private var fetcher: ImageFetcher = {
        return ImageFetcher()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareImagesAndViews()
        configureGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViewConstraints(to: view.frame.size)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.updateViewConstraints(to: size)
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // This is the first point you know for sure that scroll view size is correctly figured out,
        // because all of the constraints and layouts are already calculated.
        // Refer https://qiita.com/shtnkgm/items/f133f73baaa71172efb2 (Sorry, Japanese reference)
        scrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: scrollViewSize.width * 3, height: scrollViewSize.height)
        scrollView.contentOffset = CGPoint(x: scrollViewSize.width, y: 0)
        layoutImages()
    }

    private func configureGesture() {
        //scrollViewのジャスチャーを取得
        scrollView.gestureRecognizers?.forEach({ recognizer in
            if recognizer is UISwipeGestureRecognizer
                || recognizer is UIPanGestureRecognizer {
                // Viewにジャスチャーを追加
                view.addGestureRecognizer(recognizer)
            }
        })
    }
    //landscape、portraitでのAutolayout調整
    private func updateViewConstraints(to size: CGSize) {
        var frameWidthRatio = CGFloat(1.0)
        var frameHeightRatio = CGFloat(1.0)
        if (size.width > size.height) {
            // landscape
            frameImageView.image = UIImage(named: "green-frame-landscape")
            frameWidthRatio = 456.0
            frameHeightRatio = 385.0

            frameImageViewAspectRatioConstraintPortrait.isActive = false
            frameImageViewAspectRatioConstraintLandscape.isActive = true
        } else {
            // portrait
            frameImageView.image = UIImage(named: "green-frame-portrait")
            frameWidthRatio = 385.0
            frameHeightRatio = 456.0
            frameImageViewAspectRatioConstraintPortrait.isActive = true
            frameImageViewAspectRatioConstraintLandscape.isActive = false
        }

        let frameAspectRatio = frameHeightRatio / frameWidthRatio

        let viewAspectRatio = size.height / size.width

        if (viewAspectRatio > frameAspectRatio) {
            frameImageViewLeftConstraint.constant = 32
        } else {
            let r = (size.height - 2 * 32) / frameHeightRatio
            let x = (size.width - r * frameWidthRatio) / 2
            frameImageViewLeftConstraint.constant = x
        }
    }

    // 最初の3枚の画像を設定
    private func prepareImagesAndViews() {
        (0..<3).forEach { i in
            let image = fetcher.fetchRandomImage()
            images.append(image)
            imageViews[i].image = image
            scrollView.addSubview(imageViews[i])
        }
    }

    // 各ページのフレーム設定をするコード例
    private func layoutImages() {
        // nは0から始まる連続した整数，xはその配列の要素を表す，ペアのシーケンス（n，x）を返す。
        imageViews.enumerated().forEach { (index: Int, imageView: UIImageView) in
            imageView.image = images[index]
            // 画像を横に並べる
            imageView.frame = CGRect(x: scrollViewSize.width * CGFloat(index),
                                     y: 0,
                                     width: scrollViewSize.width,
                                     height: scrollViewSize.height)
        }
    }
}

extension ViewController: UIScrollViewDelegate {

    // スクロールビューがスクロールの動きを減速し始めたことをデリゲートに通知します。
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        dragging = true
    }

    // スクロールビューのスクロール動作の減速が終了したことをデリゲートに伝えます。
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        dragging = false
    }

    // ユーザが Receiver 内のコンテンツビューをスクロールしたことをデリゲートに通知する。
    // デリゲートは通常このメソッドを実装し、scrollView
    // からコンテンツオフセットの変化を取得し、コンテンツビューの影響を受ける部分を描画します。
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !dragging {
            return
        }

        // UIScrollViewのスクロール位置が初期状態(= contentOffset = {0, 0}）の状態から
        // x, y方向にどれだけスクロールしたかを表す。y方向に+100pxスクロールしたらcontentOffsetは{0,100}になる。
        let offsetX = scrollView.contentOffset.x

        // scrollView.frame.size.widthは見えている枠の横幅
        // 右にスワイプ
        if (offsetX > scrollView.frame.size.width * 1.5) {
            // 1. モデルをアップデート。n-1 ページ目を削除して, n+2 ページ目を追加
            let newImage = fetcher.fetchRandomImage()
            images.remove(at: 0)
            images.append(newImage)
            // 2. 後述。n ページ目から n+2 ページのフレーム設定
            layoutImages()
            // 3. ビューポートの調整
            scrollView.contentOffset.x -= scrollViewSize.width
        }
        // 左にスワイプ
        if (offsetX < scrollView.frame.size.width * 0.5) {
            // 1. モデルをアップデート。n+1 ページ目を削除して, n-2 ページ目を追加
            let newImage = fetcher.fetchRandomImage()
            images.removeLast()
            images.insert(newImage, at: 0)
            // 2. 後述。n-2 ページ目から n ページのフレーム設定
            layoutImages()
            // 3. ビューポートの調整
            scrollView.contentOffset.x += scrollViewSize.width
        }
    }
}

