//
//  StationTableViewCell.swift
//  TableViewCustomCell
//
//  Created by yoshiiikoba on 2020/09/03.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var prefecture: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // UILabelにUITableViewから受け取った値を入れる
    func setCell(station: Station) {
        self.name.text = station.name as String
        self.prefecture.text = station.prefecture as String
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
