//
//  ViewController.swift
//  UIKitViewhitTest
//
//  Created by Yoshinori Kobayashi on 2022/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    

}


class RootView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("RootView hitTest(:with:)")
        return super.hitTest(point, with: event)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let result = super.point(inside: point, with: event)
        print("RootView point(inside:with:): \(result)")
        return result
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("RootView touchesBegan(:with:)")
        super.touchesBegan(touches, with: event)
    }
}

class FrontButton: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("FrontButton hitTest(:with:)")
        return super.hitTest(point, with: event)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let result = super.point(inside: point, with: event)
        print("FrontButton point(inside:with:): \(result)")
        return result
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("FrontButton touchesBegan(:with:)")
        super.touchesBegan(touches, with: event)
    }
}

class BackButton: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("BackButton hitTest(:with:)")
        return super.hitTest(point, with: event)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let result = super.point(inside: point, with: event)
        print("BackButton point(inside:with:): \(result)")
        return result
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("BackButton touchesBegan")
        super.touchesBegan(touches, with: event)
    }
}

class BlackView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("BlackView hitTest(:with:)")
        return super.hitTest(point, with: event)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let result = super.point(inside: point, with: event)
        print("BlackView point(inside:with:): \(result)")
        return result
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("BlackView touchesBegan(:with:)")
        super.touchesBegan(touches, with: event)
    }
}
