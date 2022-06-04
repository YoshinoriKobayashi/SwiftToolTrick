//: [Previous](@previous)

import Foundation

// List13-2
// 辞書を足し合わせる演算子の定義

func +<Key, Value>(lhs:[Key:Value], rhs:[Key:Value]) -> [Key:Value] {
    var dic = lhs
    for (k, v) in rhs { dic[k] = v }
    return dic
}

let p = ["レベル":60, "特技":10]
let q = ["番号":1]
let t = p + q
print(t)

// 型パラメータの書き方
//<T>:関数定義、型定義に書くことによって、それ以下の定義でTを型パラメータとして使うことを示します。Tに対する条件はありません。
//<T,U>：型パラメータが２つ必要な場合
//<T: OtherType>:型パラメータTは、プロトコルOtherTypeに適合するか、クラスOtherType自体かそのサブクラスであることが条件になります。
// where条件：先行する型パラメータに何かしらの条件をつけます。この形の制約条件は、関数の引数列および返り値の方の宣言のあと、関数本体のコードブロックの前に書く。


