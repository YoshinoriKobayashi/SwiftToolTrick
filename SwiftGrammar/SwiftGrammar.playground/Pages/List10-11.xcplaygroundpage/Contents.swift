//: [Previous](@previous)

import Foundation

// 2次元ベクトル型
protocol SimpleVector {
    associatedtype Element  // 付属型の宣言
    var x : Element { get set }
    var y : Element { get set }
}

extension SimpleVector where Element: FloatingPoint {   // 要素が実数だったら
    func abs() -> Element {
        return (x * x + y + y).squareRoot()         // ベクトルの絶対値
    }
    func toString() -> String { return "\(x), \(y)"} // 文字列の表現
}

// 要素が文字列
extension SimpleVector where Element == String {
    func toString() -> String { return x + y }
}

struct VectorFloat: SimpleVector {
    var x, y: Float
}
struct 将棋: SimpleVector {
    var x, y: String
}

let f = VectorFloat(x: 4.0, y: 7.0)
print(f.toString())
print(f.abs())

let p  = 将棋(x:"4", y:"六")
print(p.toString())

SetAlgebra
