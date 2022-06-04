//: [Previous](@previous)

import Foundation

// 配列とシークエンスを扱う関数
// (順番、全体の個数）のタプルで返却
//　比較を行うので、要素型TはプロコトルComparableに適合しないといけない
func rank<T:Comparable>(key:T, in a:[T]) -> (Int,Int) {
    var count = 1, total = 1            // 全体の個数にはkeyもカウント
    for elm in a {
        if key > elm { count += 1}      // keyより大きい要素数を数える
        total += 1
    }
    return (count, total)
}
let words = ["red","hot","eye","flame","haze"]
rank(key: "hasssssir", in:words) // (3,6)を返す

// 関数は配列が使えるだけ、集合やコレクション、シークエンスも扱えたほうが便利
