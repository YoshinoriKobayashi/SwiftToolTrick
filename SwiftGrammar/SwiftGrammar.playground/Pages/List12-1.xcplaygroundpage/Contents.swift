import Foundation

// クロージャ
var c1 = { () -> () in print("Hello") } // 省略なし
var c2 = { () -> Void in print("Hello") } // ()とVoidは同じ
var c3 = { () in print("Hello") } // 返り値の型を省略
var c4 = { print("Hello") } // 引数も省略

var pi:Double = { () -> Double in atan(1.0)*4.0 }()
var pi2 = { atan(1.0)*4.0 }()        // クロージャの戻り値の型と変数piの型宣言の両方が省略できる

var c3_2: Int = {             // Int型を返すクロージャであると推論される
    print("What?")
    return Int(9)
}()                         // ()でクロージャ式を直接評価する

var c1_2 = { (a:Int, b:Int) -> Double in
    return Double(a) / Double(b)
}
// c1のデータ型は、(Int,Int)->Doubleになる
print(c1_2)

// 関数で同じ型を定義
func f1(a:Int,b:Int) -> Double { return Double(a) / Double(b)}
print(f1)
c1_2 = f1

print(c1_2(17, 4))  // クロージャの呼び出しで引数ラベルは使えない

// --------------------------
func bracket(name: String) { print("[\name]", terminator:"")}

// cp3オプショナル型
var cp3:((Int,Int) -> Double)?

// クロージャの配列
typealias MyClosure = (Int,Int) -> Double
var ca34 = [MyClosure]()

