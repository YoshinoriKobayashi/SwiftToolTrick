//
//  ViewController.swift
//  UIKit005
//
//  Created by yoshiiikoba on 2020/09/14.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var myImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UIImageViewのサイズを設定する
        let iWidth: CGFloat = 300
        let iHieght: CGFloat = 100
        
        // UIImageViewのx,yを設定する
        let posX: CGFloat = (self.view.bounds.width - iWidth) / 2
        let posY: CGFloat = (self.view.bounds.height - iHieght) / 2
        
        // UIImagViewを作成
        myImageView = UIImageView(frame: CGRect(x:posX, y:posY, width: iWidth, height: iHieght)) 
        
        var imageData:Data? = nil
        
        // UIImageを作成
        do {
            imageData = try Data(contentsOf: URL(string:"https://ticklecode.com/wp/wp-content/uploads/2016/06/logo_ticklecode.png")!)
        } catch {
            //
        }
        
        let myImage: UIImage = UIImage(data:imageData!)!

        // 画像をUIImageViewに設定する
        myImageView.image = myImage
        
        // UIImageViewをViewに追加する
        self.view.addSubview(myImageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can bi recreated.
    }


}

