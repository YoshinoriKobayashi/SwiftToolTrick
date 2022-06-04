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
