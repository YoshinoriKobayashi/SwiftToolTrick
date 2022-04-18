//
//  ViewController.swift
//  UIKItScrollView
//
//  Created by kobayashi on 2022/04/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    // ScrollScreenの高さ
     var scrollScreenHeight:CGFloat!
     // ScrollScreenの幅
     var scrollScreenWidth:CGFloat!

     let img:[String] = ["universe1","universe2","universe3","universe4"]
     // Totalのページ数
     var pageNum:Int!

     var imageWidth:CGFloat!
     var imageHeight:CGFloat!
     var screenSize:CGRect!

     override func viewDidLoad() {
         super.viewDidLoad()

         screenSize = UIScreen.main.bounds

         // ページスクロールとするためにページ幅を合わせる
         scrollScreenWidth = screenSize.width

         let imageTop:UIImage = UIImage(named:img[0])!
         pageNum = img.count

         imageWidth = imageTop.size.width
         imageHeight = imageTop.size.height
         scrollScreenHeight = scrollScreenWidth * imageHeight/imageWidth

         for i in 0 ..< pageNum {
             // UIImageViewのインスタンス
             // 画像ごとにそのframeサイズを設定
             let image:UIImage = UIImage(named:img[i])!
             let imageView = UIImageView(image:image)

             var rect:CGRect = imageView.frame
             rect.size.height = scrollScreenHeight
             rect.size.width = scrollScreenWidth

             imageView.frame = rect
             imageView.tag = i + 1

             // UIScrollViewのインスタンスに画像を貼付ける
             // addSubview でUIScrollViewに加える
             self.scrollView.addSubview(imageView)

         }

         setupScrollImages()

     }

     func setupScrollImages(){

         // ダミー画像
         let imageDummy:UIImage = UIImage(named:img[0])!
         var imgView = UIImageView(image:imageDummy)
         let subviews:Array = scrollView.subviews

         // 描画開始の x,y 位置
         var px:CGFloat = 0.0
         let py:CGFloat = (screenSize.height - scrollScreenHeight)/2

         // verticalScrollIndicatorとhorizontalScrollIndicatorが
         // デフォルトで入っているので2から始める
         for i in 2 ..< subviews.count {
             imgView = subviews[i] as! UIImageView
             if (imgView.isKind(of: UIImageView.self) && imgView.tag > 0){

                 var viewFrame:CGRect = imgView.frame
                 viewFrame.origin = CGPoint(x: px, y: py)
                 imgView.frame = viewFrame

                 px += (scrollScreenWidth)

             }
         }
         // UIScrollViewのコンテンツサイズを画像のtotalサイズに合わせる
         let nWidth:CGFloat = scrollScreenWidth * CGFloat(pageNum)
         scrollView.contentSize = CGSize(width: nWidth, height: scrollScreenHeight)

     }


}

