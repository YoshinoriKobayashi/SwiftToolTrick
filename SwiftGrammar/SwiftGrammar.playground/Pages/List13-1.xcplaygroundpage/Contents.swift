//: [Previous](@previous)

import Foundation

// ジェネリック関数の定義
func mySwap<T>(_ a: inout T, _ b: inout T) {  //　ジェネリック関数
    let t = a; a = b; b = t
}

var a = "AIZ", b = "bell"
mySwap(&a, &b)
print("a=\(a), b=\(b)")
var s = (1,2),t = (100,50)
mySwap(&s, &t)

// List13-2
// 辞書を足し合わせる演算子の定義

func +<Key, Value>(lhs:[Key:Value], rhs:[Key:Value]) -> [Key:Value] {
    var dic = lhs
    for (k, v) in rhs { dic[k]}
}
