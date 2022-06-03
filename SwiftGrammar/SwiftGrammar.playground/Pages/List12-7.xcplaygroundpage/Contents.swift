import Foundation

// List12-7 キャプチャリストの例
var a,b,c: () -> () // クロージャを代入する変数
do {
    var count = 0
    var name = "PASCAL"
    a = { print("A:\(count), \(name)")}
    b = { [count] in print("B: \(count), \(name)")} // []をキャプチャリスト
    c = { [name, count] in print("C: \(count), \(name)")}

    count = 1       // クロージャを代入してから変数の値を変更
    name = "Swift"
}
a()
b()
c()

// 引数リストの省略
var clos:(Int,Int) -> String
= { (a:Int, b:Int) -> String in return "\(a)/\(b)"}

//// 変数のデータ型が省略、returnが省略
//var clos2: { a,b -> String in "\(a)/\(b)"}
//
//// 戻り値の方もわかっているので省略
//var clos3: { a,b -> in "\(a)/\(b)"}
//
//// 引数を省略するとinも省略できる、引数の数がわかるので、名前を省略できる。
//var clos4: { "\($0)/\($1)" }


// 配列の整列
let list = ["fig.gif","filelist1.swift","OLD","sample.swift"]

let slist = list.sorted(by: {
    (a: String, b: String) -> Bool in a < b
})

// lsitは文字列の配列とわかっているため、次のように省略できる
let slist2 = list.sorted(by: { $0 < $1 })

// 演算子「<」は引数を2つとる関数と同じなので
let slist3 = list.sorted(by: <)
print(slist)
