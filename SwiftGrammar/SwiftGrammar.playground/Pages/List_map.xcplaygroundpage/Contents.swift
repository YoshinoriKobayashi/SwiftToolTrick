//: [Previous](@previous)

import Foundation
import CoreFoundation

// func map<U>(_: (T) throws -> U) rethrows -> [U]
// selfの持つ要素に引数のクロージャを適用してU型のデータを生成し、これから新しい配列として返します。

let screen = [12.0, 13.0, 15.0, 21.5, 27,0]
let dim = screen.map{ $0 * 2.54 }.filter{ $0 < 50.0 }
print(dim)

// 辞書については、含まれる要素の値に対して処理を適用し、その結果とキーを組み合わせて、新しい辞書を返すメソッドが提供されている。
// func mapValues<U>(_: (Value) throws -> U) rethrows -> [Key:U]
let steps = [90,80,70,60]                   // 基準の点数（降順）
let evals = ["秀","優","良","可","不可"]     // 評価を示す文字列
let m = ["春信":68, "香子":52, "あかり":90, "レイ":75]   // データ
let marks = m.mapValues{ (point: Int) -> String in
    var index = 0
    for s in steps {
        print(s)
        // 順番に基準点と比較する
        if point >= s { break }
        index += 1
    }
    return evals[index]
}
print(marks)

// シークエンスメソッドcompactMapはmapのように処理結果を配列として返します。
// 引数のクロージャがnilを返り値とした場合は、結果の配列に含めません。
// func compactMap<E>(_: (T) throws -> E?) rethrows -> [E]

let people = [
    ["Name":"結衣", "Pet":"犬", "BloodType":"0"],
    ["Name":"翔子", "Pet":"猫"],
    ["Name":"麻衣", "BloodType":"AB"],
    ["Name":"光子", "Pet":"蛇", "Level":"4"],
]
let pets = people.compactMap{
    $0["Pet"]
}
print(pets)

// flatMap
// シークエンスを０返すクロージャを引数として、それらのシークエンスのすべての要素を含む配列を返す。
// クロージャが返すシークエンスは要素を含まなくても構いません。
// Tはレシーバであるシークエンスを要素型としてますが、一方、S.Elementとあるのは　クロージャが返すシークエンスの要素型で、これらは同一である必要はない

//func flatMap<S>(_: (T) throws -> S) rethrows -> [S.Element]

// 生徒の名前をキーとした読書リスト、すべての書名をまとめた配列を得る方法

let booklists = [
    "結衣":["夢の通路","夢の浮橋"],
    "翔子":["聖少女"],
    "麻衣":[],
    "光子":["悪い夏","反悲劇","ポポイ"]
    ]
print(booklists.map{ $0.value })
print(booklists.compactMap{ $0.value })
print(booklists.flatMap{ $0.value })
