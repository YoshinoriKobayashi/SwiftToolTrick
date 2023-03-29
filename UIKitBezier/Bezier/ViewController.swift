//
//  ViewController.swift
//  Bezier
//
//  Created by Yoshinori Kobayashi on 2023/03/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let myView = MyView(frame: view.bounds)
        view.addSubview(myView)
        
    }


}


class MyView: UIView {
    let point1 = CGPoint(x: 100, y: 200)
    let point2 = CGPoint(x: 200, y: 300)
    let point3 = CGPoint(x: 300, y: 100)
    let yPosi = CGPoint(x: 300, y: 400)
    let xPosi = CGPoint(x: 100, y: 400)
    
    override func draw(_ rect: CGRect) {
        }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        
        UIGraphicsPushContext(ctx)
        
        let count = 100
        
        // グラデーションレイヤーの生成
        let gradLayer = CAGradientLayer()
        gradLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        gradLayer.colors = [
            UIColor(red: 244/255, green: 206/255, blue: 147/255, alpha: 1.0).cgColor,
            UIColor(red: 240/255, green: 225/255, blue: 207/255, alpha: 1.0).cgColor
        ]
        
        
        let path = UIBezierPath()
        path.move(to: point1)
        (0...count).forEach {
            let point4 = CGPoint(
                x: point1.x + (point2.x - point1.x) * CGFloat($0) / CGFloat(count),
                y: point1.y + (point2.y - point1.y) * CGFloat($0) / CGFloat(count)
            )
            let point5 = CGPoint(
                x: point2.x + (point3.x - point2.x) * CGFloat($0) / CGFloat(count),
                y: point2.y + (point3.y - point2.y) * CGFloat($0) / CGFloat(count)
            )
            let point6 = CGPoint(
                x: point4.x + (point5.x - point4.x) * CGFloat($0) / CGFloat(count),
                y: point4.y + (point5.y - point4.y) * CGFloat($0) / CGFloat(count)
            )
            path.addLine(to: point6)
        }
        path.addLine(to: point3)
        path.addLine(to: yPosi)
        path.addLine(to: xPosi)
        path.close()
        
        // 三角レイヤーのシェイプを生成
        let ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer.path = path.cgPath
        
        // マスクを設定
        gradLayer.mask = ovalShapeLayer
        
        // 描写
        layer.addSublayer(gradLayer)
        UIGraphicsPopContext()
        
        }
}
