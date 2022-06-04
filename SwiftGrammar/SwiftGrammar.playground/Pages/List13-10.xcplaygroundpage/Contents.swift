//: [Previous](@previous)

import Foundation
import CoreFoundation

protocol SimpleVector {     //  2次元ベクトル型
    associatedtype Element  //　付属型の宣言
    var x: Element { get set }
    var y: Element { get set }
}

struct Vector<T> : SimpleVector {
    typealias Element = T   // 付属型をパラメータで指定されたデータ型で定義
    var x,y: Element        // 格納型プロパティ

}
let a: Vector<Int> = Vector<Int>(x:12, y:3)
print(a.x, a.y) // 12 3 表示
let b = Vector<[String]>(x:[], y:["黒","noir","schwarz"]) // 使用可能

print(b)
