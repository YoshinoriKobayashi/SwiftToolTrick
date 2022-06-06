//: [Previous](@previous)

import Foundation

// List 13-14

protocol SimpleVector {     //  2次元ベクトル型
    associatedtype Element  //　付属型の宣言
    var x: Element { get set }
    var y: Element { get set }
}

struct Vector<T> : SimpleVector {
    typealias Element = T   // 付属型をパラメータで指定されたデータ型で定義
    var x,y: Element        // 格納型プロパティ

}

// プロパティcountだけを含むプロコトルCountableの定義と、String型がこの型に適合するようにした拡張定義
protocol Counttable {           // プロコトル　Couttableの定義
    var count: Int { get }
}

extension String: Counttable {}

// 型パラメータによる条件が付いた形式
// 型パラメータElementがプロコトルCountableに適合している場合、
// Vector型もCountableに適合するという定義
extension Vector: Counttable where Element: Counttable {
    var count: Int { x.count + y.count }
}

let s = Vector(x:"Me",y:"You")
print(s.count)  // 5を出力
let t = Vector(x: s, y: Vector(x: "Hiro", y: "02"))
print(t.count)  // 11を出力
