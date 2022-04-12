//
//  CollectionViewCell.swift
//  UICollectionView_CodeOnly
//
//  Created by kobayashi on 2022/04/12.
//

import Foundation
import UIKit

final class CollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let fruitsNameLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x:0, y:0, width: screenSize.width / 2.0, height: screenSize.width / 2.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()


    private func setup() {
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 3.0

        contentView.addSubview(fruitsNameLabel)
    }

    func setupContents(textName: String) {
        fruitsNameLabel.text = textName
    }
}
