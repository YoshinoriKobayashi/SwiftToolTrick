//
//  ViewController.swift
//  UIKit003
//
//  Created by yoshiiikoba on 2020/08/17.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var myInfoDarkButton: UIButton!
    private var myInfoLightButton: UIButton!
    private var myAddButton: UIButton!
    private var myDetailButton: UIButton!
    private var mySystemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ボタンを生成
        myInfoDarkButton = UIButton(type: .infoDark)
        myInfoLightButton = UIButton(type: .infoLight)
        myAddButton = UIButton(type: .contactAdd)
        myDetailButton = UIButton(type: .detailDisclosure)
        mySystemButton = UIButton(type: .system)
        
        // ボタンの位置を指定する
        let posX: CGFloat = self.view.frame.width / 2
        myInfoDarkButton.layer.position = CGPoint(x: posX, y:50)
        myInfoLightButton.layer.position = CGPoint(x: posX, y:100)        
        myAddButton.layer.position = CGPoint(x: posX, y:150)
        myDetailButton.layer.position = CGPoint(x: posX, y:200)
        
        // Systemボタンのサイズ
        let sWidth: CGFloat = 200
        let sHeight: CGFloat = 50
        // Systemボタンの配置する x,y 座標
        let sposX: CGFloat = self.view.frame.width / 2 - sWidth / 2
        let sposY: CGFloat = 250
        
        // Sytemボタンに配置する x,y 座標とサイズを設定
        mySystemButton.frame = CGRect(x :sposX,y: sposY,width: sWidth,height: sHeight)
        
        
        // Systemボタンにタイトルを設定する
        mySystemButton.setTitle("MySystemButton", for: .normal)
        
        // タグを設定する
        myInfoDarkButton.tag = 1
        myInfoLightButton.tag = 2
        myAddButton.tag = 3
        myDetailButton.tag = 4
        mySystemButton.tag = 5
        
        // イベントを追加する
        myInfoDarkButton.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchDown)
        myInfoLightButton.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchDown)
        myAddButton.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchDown)
        myDetailButton.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchDown)
        mySystemButton.addTarget(self, action: #selector(ViewController.onClickMyButton(sender:)), for: .touchDown)
        
        // ボタンを View に追加する
        self.view.addSubview(myInfoDarkButton)
        self.view.addSubview(myInfoLightButton)
        self.view.addSubview(myAddButton)
        self.view.addSubview(myDetailButton)
        self.view.addSubview(mySystemButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    // ボタンイベント
    @objc internal func onClickMyButton(sender: UIButton) {
        print("onClickMyButton:")
        
        if let title = sender.currentTitle {
            print("sender.currentTittle:\(title)")
        }
        
        print("sender.tag\(sender.tag)")
    }

}

