//
//  Station.swift
//  TableViewCustomCell
//
//  Created by yoshiiikoba on 2020/09/03.
//  Copyright © 2020 Kobayashi Yoshinori. All rights reserved.
//

import Foundation

class Station:NSObject {
    var name: String
    var prefecture: String
    
    init(name: String, prefecture: String) {
        self.name = name as String
        self.prefecture = prefecture as String
    }
}
