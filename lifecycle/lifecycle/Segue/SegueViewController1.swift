//
//  SegueViewController1.swift
//  lifecycle
//
//  Created by Swift-Beginners on 2021/03/18.
//

import UIKit

class SegueViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("画面A:\(#function)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("画面A:\(#function)")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("画面A:\(#function)")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("画面A:\(#function)")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("画面A:\(#function)")
    }
    

}
