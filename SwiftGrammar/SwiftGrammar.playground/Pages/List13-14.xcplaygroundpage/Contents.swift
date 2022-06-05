//: [Previous](@previous)

import Foundation

// List 13-14
protocol Counttable {           // プロコトル　Couttableの定義
    var count: Int { get }
}

extension String: Counttable {}
extension Vector: Counttable where Element: Counttable {
    var count: Int { x.count + y.count }
}
