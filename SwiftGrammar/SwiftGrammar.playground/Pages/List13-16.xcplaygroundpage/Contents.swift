//: [Previous](@previous)

import Foundation

// 不透明型
// プロトコルの返り値の型として使う

protocol Named {
    var name:String { get }
}

func compareNames<T>(_ a: T, _ b: T) -> Named where T: Named {
    return (a.name > b.name) ? a : b
}

struct Person: Named {
    var name: String
}

let a = Person(name: "スバル")
let b = Person(name: "なおふみ")
let c = compareNames(a,b)
print(c.name)
