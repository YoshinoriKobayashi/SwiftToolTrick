//
//  ViewController.swift
//  UIGestureRecognizer
//
//  Created by Swift-Beginners on 2021/04/01.
//

import UIKit

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
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
            // ズームのタイミングでcontentInsetを更新
            updateScrollInset()
        }

    
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            if let size = imageView.image?.size {
                // imageViewのサイズがscrollView内に収まるように調整
                let wrate = scrollView.frame.width / size.width
                let hrate = scrollView.frame.height / size.height
                let rate = min(wrate, hrate, 1)
                imageView.frame.size = CGSize(width: size.width * rate, height: size.height * rate)

                // contentSizeを画像サイズに設定
                scrollView.contentSize = imageView.frame.size
                // 初期表示のためcontentInsetを更新
                updateScrollInset()
            }
        }
    
    private func updateScrollInset() {
            // imageViewの大きさからcontentInsetを再計算
            // なお、0を下回らないようにする
        scrollView.contentInset = UIEdgeInsets(
            top: max((scrollView.frame.height - imageView.frame.height)/2, 0),
            left: max((scrollView.frame.width - imageView.frame.width)/2, 0),
            bottom: 0,
            right: 0
            );
        }
    
    
    

    // https://studio.beatnix.co.jp/develop/swift/image-zoom-uiscrollview/
    // https://studio.beatnix.co.jp/develop/swift/image-zoom-gesture/
    // https://tech.playground.style/swift/scrollview_zoom/
    // https://qiita.com/wmoai/items/52b1901e62d28dae9f91
    // https://qiita.com/Swift-User/items/67a5dd3d9eabf513aa2c
    // https://dev.to/avyavya/storyboard-auto-layout-uiscrollview-w-xcode-11-21b0
    

    
    //           // ピンチを定義
//           //let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(PinchCodeViewController.pinchView(_:)))  //Swift2.2以前
//           let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchView(sender:)))  //Swift3
//           // viewにピンチを登録
        
        
//           self.view.addGestureRecognizer(pinchGesture)
           
//       }
       
//       /// ピンチイン・ピンチアウト時に実行される
//       @objc func pinchView(sender: UIPinchGestureRecognizer) {
//           print("pinch")
//           // ピンチイン・ピンチアウトの拡大縮小率
//           print("scale: \(sender.scale)")
//           // 1秒あたりのピンチの速度(read-only)
//           print("velocity: \(sender.velocity)")
//       }
}

