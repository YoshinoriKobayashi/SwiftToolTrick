import Foundation

var globalCount = 6

// ()->Int という型をもつクロージャのインスタンスを作って返す関数
func maker(_ a:Int, _ b:Int) -> () -> Int {
    var localvar = a

    return { () -> Int in       // クロージャ式。型宣言は省略可能
        globalCount += 1        // globalCountは参照されるだけ
        localvar += b           // localvar,bがキャプチャされる
        return localvar
    }
}

var m1 = maker(10,1)
print("m1() = \(m1()), globalCount = \(globalCount)")
print("m1() = \(m1()), globalCount = \(globalCount)")
globalCount = 1000
print("m1() = \(m1()), globalCount = \(globalCount)")
var m2 = maker(50,2)
print("m2() = \(m2()), globalCount = \(globalCount)")
print("m1() = \(m1()), globalCount = \(globalCount)")
print("m2() = \(m2()), globalCount = \(globalCount)")

