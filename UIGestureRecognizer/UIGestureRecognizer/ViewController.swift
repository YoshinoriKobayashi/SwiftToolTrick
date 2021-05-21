//
//  ViewController.swift
//  UIGestureRecognizer
//
//  Created by Swift-Beginners on 2021/04/01.
//

import UIKit

/*
参考サイト
https://studio.beatnix.co.jp/develop/swift/image-zoom-gesture
https://program-life.com/519
 

 */

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var tapGesture: UITapGestureRecognizer!
    var pinchGesture: UIPinchGestureRecognizer!
    var longTapGesture: UILongPressGestureRecognizer!
    var swipeGestureUp: UISwipeGestureRecognizer!
    var swipeGestureUpTwo: UISwipeGestureRecognizer!
    var swipeGestureLeft: UISwipeGestureRecognizer!
    var swipeGestureLeftTwo: UISwipeGestureRecognizer!
    var swipeGestureRight: UISwipeGestureRecognizer!
    var swipeGestureRightTwo: UISwipeGestureRecognizer!
    var swipeGestureDown: UISwipeGestureRecognizer!
    var swipeGestureDownTwo: UISwipeGestureRecognizer!
    
    var pichCenter:CGPoint!
    var pinchStartImageCenter:CGPoint!
    var currentTransform:CGAffineTransform!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap
        tapGesture = UITapGestureRecognizer(target: self,action: #selector(ViewController.tap))
        view.addGestureRecognizer(tapGesture)
        
        // Pinch
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinch))
        view.addGestureRecognizer(pinchGesture)
        
        // Long Tap
        longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longTap))
        view.addGestureRecognizer(longTapGesture)
        
        // Swipe Up
        swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeUp))
        swipeGestureUp.direction = .up
        view.addGestureRecognizer(swipeGestureUp)
        
        // Swipe Up Two
        swipeGestureUpTwo = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeUpTwo))
        swipeGestureUpTwo.direction = .up
        swipeGestureUpTwo.numberOfTouchesRequired = 2
        view.addGestureRecognizer(swipeGestureUpTwo)
        
        // Swipe Left
        swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeLeft))
        swipeGestureLeft.direction = .left
        view.addGestureRecognizer(swipeGestureLeft)
        
        // Swipe Left Two
        swipeGestureLeftTwo = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeLeftTwo))
        swipeGestureLeftTwo.direction = .left
        swipeGestureLeftTwo.numberOfTouchesRequired = 2
        view.addGestureRecognizer(swipeGestureLeftTwo)
        
        // Swipe Right
        swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeRight))
        swipeGestureRight.direction = .right
        view.addGestureRecognizer(swipeGestureRight)
        
        // Swipe Right Two
        swipeGestureRightTwo = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeRightTwo))
        swipeGestureRightTwo.direction = .right
        swipeGestureRightTwo.numberOfTouchesRequired = 2
        view.addGestureRecognizer(swipeGestureRightTwo)
        
        // Swipe Down
        swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeDown))
        swipeGestureDown.direction = .down
        view.addGestureRecognizer(swipeGestureDown)
        
        // Swipe Down Two
        swipeGestureDownTwo = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeDownTwo))
        swipeGestureDownTwo.direction = .down
        swipeGestureDownTwo.numberOfTouchesRequired = 2
        view.addGestureRecognizer(swipeGestureDownTwo)
        
    }
    
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        print("Tap")
    }
    
    @objc func pinch(_ sender: UIPinchGestureRecognizer) {
        print("Pinch")
        
        if sender.state ==  .began {
            // ピンチジェスチャー・開始
            currentTransform = imageView.transform
            
            // ピンチを開始したときの画像の中心点を保存しておく
            pinchStartImageCenter = imageView.center
            
            let touchPoint1 = sender.location(ofTouch: 0, in: self.imageView)
            let touchPoint2 = sender.location(ofTouch: 1, in: self.imageView)
            
            // 指の中間点を求めて保存しておく
            // UIGestureRecognizerState.Changedで毎回求めた場合、ピンチ状態で片方の指だけ動かしたときに中心点がずれておかしな位置でズームされるため
            pichCenter = CGPoint(x: (touchPoint1.x + touchPoint2.x) / 2, y: (touchPoint1.y + touchPoint2.y) / 2)
            
        } else if sender.state == .changed {
            // ピンチジェスチャー・変更中
            let scale = sender.scale // ピンチを開始してからの拡大率。差分ではない
            
            // ピンチした位置を中心としてズーム（イン/アウト）するように、画像の中心位置をずらす
            let newCenter = CGPoint(
                x: pinchStartImageCenter.x - ((pichCenter.x - pinchStartImageCenter.x) * scale - (pichCenter.x - pinchStartImageCenter.x)),
                y: pinchStartImageCenter.y - ((pichCenter.y - pinchStartImageCenter.y) * scale - (pichCenter.y - pinchStartImageCenter.y)))
            
            imageView.center = newCenter
            
            imageView.transform = currentTransform.concatenating(CGAffineTransform(scaleX: scale, y: scale))
            
        } else if sender.state == .ended {
            // ピンチジェスチャー終了
            
            // 現在の拡大率を取得する
            let currentScale = sqrt(abs(imageView.transform.a * imageView.transform.d - imageView.transform.b * imageView.transform.c))
            
            // 初期サイズより小さい場合は、初期サイズに戻す
            if currentScale < 1.0 {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {() -> Void in
                    self.imageView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
                    self.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                }, completion: {(finished: Bool) -> Void in
                })
            }
        }
        
    }
    
    @objc func longTap(_ sender: UILongPressGestureRecognizer) {
        print("Long Tap")
    }
    
    @objc func swipeUp(_ sender: UISwipeGestureRecognizer) {
        print("Swipe Up")
    }
    
    @objc func swipeUpTwo(_ sender: UISwipeGestureRecognizer) {
        print("Swipe Up Two")
    }
    
    @objc func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        print("Swipe Left")
    }
    
    @objc func swipeLeftTwo(_ sender: UISwipeGestureRecognizer) {
        print("Swipe Left Two")
    }
    
    @objc func swipeRight(_ sender: UISwipeGestureRecognizer) {
        print("Swipe Right")
    }
    
    @objc func swipeRightTwo(_ sender: UISwipeGestureRecognizer) {
        print("Swipe Right Two")
    }
    
    @objc func swipeDown(_ sender: UISwipeGestureRecognizer) {
        print("Swipe Down")
    }
    
    @objc func swipeDownTwo(_ sender: UISwipeGestureRecognizer) {
        print("Swipe Down Two")
    }
    
}
