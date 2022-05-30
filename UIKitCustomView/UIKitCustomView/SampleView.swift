//
//  SampleView.swift
//  UIKitCustomView
//
//  Created by kobayashi on 2022/05/30.
//

import UIKit

final class SampleView: UIView {
    init() {
        super.init(frame: .zero)

        // Xibを使用するためのコード
        let view = UINib(nibName: "SampleView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been im")
    }
}
