//
//  ViewController.swift
//  UIGestureRecognizer
//
//  Created by Swift-Beginners on 2021/04/01.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    // ズーム変更
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
//        self.updateImageCenter()
    }
    
    /// ズーム完了
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
//        self.updateImageCenter()
    }
    
//    /// ズーム後の画像の位置を調整する
//    func updateImageCenter() {
//
//        let image = imageView.image
//
//        // UIViewContentMode.ScaleAspectFit時のUIImageViewの画像サイズを求める
//        let frame = AVMakeRect(aspectRatio: image!.size, insideRect: imageView.bounds)
//
//        var imageSize = CGSize(width: frame.size.width, height: frame.size.height)
//        imageSize.width *= scrollView.zoomScale
//        imageSize.height *= scrollView.zoomScale
//
//        var point: CGPoint = CGPoint.zero
//        point.x = imageSize.width / 2
//        if imageSize.width < scrollView.bounds.width {
//            point.x += (scrollView.bounds.width - imageSize.width) / 2
//        }
//        point.y = imageSize.height / 2
//        if imageSize.height < scrollView.bounds.height {
//            point.y += (scrollView.bounds.height - imageSize.height) / 2
//        }
//        imageView.center = point
//    }
    
//
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//            return imageView
//        }
//
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//            // ズームのタイミングでcontentInsetを更新
//            updateScrollInset()
//        }
//
//
//
//    override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//            if let size = imageView.image?.size {
//                // imageViewのサイズがscrollView内に収まるように調整
//                let wrate = scrollView.frame.width / size.width
//                let hrate = scrollView.frame.height / size.height
//                let rate = min(wrate, hrate, 1)
//                imageView.frame.size = CGSize(width: size.width * rate, height: size.height * rate)
//
//                // contentSizeを画像サイズに設定
//                scrollView.contentSize = imageView.frame.size
//                // 初期表示のためcontentInsetを更新
//                updateScrollInset()
//            }
//        }
//
//    private func updateScrollInset() {
//            // imageViewの大きさからcontentInsetを再計算
//            // なお、0を下回らないようにする
//        scrollView.contentInset = UIEdgeInsets(
//            top: max((scrollView.frame.height - imageView.frame.height)/2, 0),
//            left: max((scrollView.frame.width - imageView.frame.width)/2, 0),
//            bottom: 0,
//            right: 0
//            );
//        }
//
//
    

    // https://studio.beatnix.co.jp/develop/swift/image-zoom-uiscrollview/
    // https://studio.beatnix.co.jp/develop/swift/image-zoom-gesture/
    // https://tech.playground.style/swift/scrollview_zoom/
    // https://qiita.com/wmoai/items/52b1901e62d28dae9f91
    // https://qiita.com/Swift-User/items/67a5dd3d9eabf513aa2c
    // https://dev.to/avyavya/storyboard-auto-layout-uiscrollview-w-xcode-11-21b0
    // https://qiita.com/owen/items/2fab4a4482834b95e349
    
    

}


