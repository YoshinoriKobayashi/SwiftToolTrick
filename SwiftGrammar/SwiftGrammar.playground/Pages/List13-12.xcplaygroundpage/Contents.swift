//: [Previous](@previous)

import Foundation
import Darwin

// 拡張定義の制約に型パラメータを使う例

// プロトコルの拡張定義（extention）には、型パラメータによる制約をつけることができる

struct PickForever<T> {    // 要素を繰り返し取り出し続ける
    var list: [T]
    private var index = 0
    init<S>(_ a: S) where S: Sequence, T == S.Element {
        list = [T](a)       // 初期値はシークエンスで指定
    }
    mutating func pick() -> T { // 要素を順番に取り出す
        if index >= list.count{ index = 0 } // 末尾を過ぎたら先頭に戻る
        let rtn = list[index]
        index += 1
        return rtn
    }
}

extension PickForever where T : Comparable {    // 大小比較できる
    mutating func sort() { list.sort() }      // 昇順にソートする
}

extension PickForever where T : Hashable {      // ハッシュ値が使える
    mutating func makeUnique() {
        let tmp = Set<T>(list)                  // 集合にして重複要素を削除する
        list = [T](tmp)                         // 配列に戻すが元の順序ではない
    }
}

let t = [(4, "多摩"),(2, "阿波"),(1, "薩摩")]
var a = PickForever<(Int,String)>(t)
for _ in 0..<5 {
    print(a.pick().1, terminator: " ")
}
print()
