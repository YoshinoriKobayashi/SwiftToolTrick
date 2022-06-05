//: [Previous](@previous)

import Foundation
import Darwin

// 拡張定義の制約に型パラメータを使う例

// プロトコルの拡張定義（extention）には、型パラメータによる制約をつけることができる

// 含まれつ要素の型をT
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

// 拡張定義に型の制約に基づいて、記述をグループ化
extension PickForever where T : Comparable {    // 大小比較できる
    mutating func sort() { list.sort() }      // 昇順にソートする
}

// hashableプロコトルに適合していえるとSetの機能を使って拘束に要素の検索が可能
extension PickForever where T : Hashable {      // ハッシュ値が使える
    mutating func makeUnique() {
        let tmp = Set<T>(list)                  // 集合にして重複要素を削除する
        list = [T](tmp)                         // 配列に戻すが元の順序ではない
    }
}

// List13-13 拡張定義の制約として型がお暗示であることを指定
// 型パラメータTがString型のときだけ使用できる拡張定義
extension PickForever where T == String {
    mutating func concatenate(_ n: Int) -> String {
        guard list.count > 0, n > 0 else { return "" }
        var buf = self.pick()
        for _ in 1 ..< n { buf += ":" + self.pick() }
        return buf
    }
}

// (4, "多摩")はタプル
let t = [(4, "多摩"),(2, "阿波"),(1, "薩摩")]
// 変数aには、sort()やmakeUnique()は実行できない
var a = PickForever<(Int,String)>(t)
for _ in 0..<5 {
    print(a.pick().1, terminator: " ")
}
print()

// ここでは拡張定義の２つが両方つける
// 文字列型が、ComparableとHashableをもっているから
var b = PickForever("こさかかいがげあｇじぇあ")
b.makeUnique()
b.sort()
for _ in 0 ..< 10 { print(b.pick(), terminator: " ")}
print()

var c = PickForever(["初雪","吹雪","白雪","深雪"])
print(c.concatenate(2))
print(c.concatenate(7))

