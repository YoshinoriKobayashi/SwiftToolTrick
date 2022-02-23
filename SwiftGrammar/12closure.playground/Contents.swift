// クロージャ

// インスタンス
var c1 = { () -> () in print("Hello")}
c1()       // "Hello" と表示
// ・実行する文の前にinキーワードが必要
// ・仮引数と戻り値の指定は関数と同じ
// ・実行する文が1行のときはreturnを省略できる

let c2 = {(a:Int,b:Int) -> Double in 
    if b == 0 { return 0.0 }
    return Double(a) / Double(b)
}
print(c2(10,8))     // 1.25
// inの文が2行以上はreturnが必要

// クロージャの省略
// 1文しかないときは帰り値の型がわかるので省略できる
var c3 = {() -> () in print("Hello")}       // 省略なし
var c4 = {() -> Void in print("Hello")}     // ()とVoidは同じ
var c5 = {() in print("Hello")}             // 返り値の型を省略
var c6 = {print("Hello")}                   // 引数も省略

// クロージャの複雑な型宣言
var cp1: (Int,Int) -> Double?       // 引数がInt型2つでDouble型のオプショナル型を返すクロージャ
var cp2: ((Int,Int) -> Double)?     // nilとクロージャが代入できる
