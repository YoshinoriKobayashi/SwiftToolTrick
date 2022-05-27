import Foundation

// クロージャが参照型の値を強い参照で保持することの確認
class MyInt {
    var value = 0
    init(_ v:Int) { value = v }

    // deinitで解放のタイミングを調べる
    deinit {
        print("deinit: \(value)")   // 解放時に表示
    }
}

// 戻り値がクロージャ
func makerZ(_ a:MyInt, _ s:String) -> () -> () {
    let localvar = a
    return {                    // クロージャを返す
        // ローカル変数をキャプチャ
        // インスタンス化されたクラスMyIntのvalueを足し込む
        localvar.value += 1
        print("\(s): \(localvar.value)")
    }
}

// トップレベルで変数obj、m1，m2をオプショナル型として宣言しているのは、
// nilを代入できるようにするため

// 変数objがもつMyIntの同一のインスタンスをキャプチャすることになる
var obj: MyInt! = MyInt(10)            // クラスのインスタンス
var m1:(()->())! = makerZ(obj,"m1")     // クロージャを変数m1に代入
m1()                                    // "m1:11"と出力
var m2:(()->())! = makerZ(obj,"m2")     // クロージャを変数m2に代入
obj = nil                               // MyIntのインスタンスはまだ解放されない
m2()                                    // "m2: 12"を出力
m1()                                    // "m1: 13"と出力
m1 = nil
m2()                                    // "m2: 14"と出力
m2 = nil                                // "deinit: 14"と出力。MyIntのインスタンスが解放された


