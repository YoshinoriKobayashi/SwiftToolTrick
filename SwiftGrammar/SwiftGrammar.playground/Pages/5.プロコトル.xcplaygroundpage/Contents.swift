//: [Previous](@previous)

import Foundation
import Darwin

// List5-2　プロトコルCustomStringConvertibleを採用
// 時間と分のみを持つTime型
struct Time: CustomStringConvertible { // プロトコルを採用
    let hour, min : Int  // 定数で時刻を保持。全項目イニシャライザを使う
    func advanced(min:Int) -> Time {    // 分を加算する
        var m = self.min + min
        var h = self.hour
        if m >= 60 {
            h = (h + m / 60) % 24
            m %= 60
        }
        return Time(hour:h, min:m) // 新しいインタンスを返す
    }
//    func toSting() -> String {  // 時刻を文字列として返す
//        let h = hour < 10 ? "\(hour)" : "\(hour)"
//        let m = min < 10 ? "0\(min)" : "\(min)"
//        return h + ":" + m
//    }

    var description: String {
        let h = hour < 10 ? " \(hour)" : "\(hour)"
        let m = min < 10 ? "0\(min)" : "\(min)"
        return h + ":" + m
    }
}
let tm = Time(hour: 19, min: 40)
print(tm)
let t2 = tm.advanced(min: 20)
print("時刻は\(t2)です")
// CustomStringConvertibleを採用することで、構造体のインスタンスが、print関数の引数にできたり、文字列に埋め込むことができるようになる

// List5-3 プロトコルHuman
protocol Human {
    var name: String? { get }   // 名前
    func sayHello(to: Human)     // 人に挨拶する
}

// List5-4 プロコトルHumanを採用した構造体Mob
struct Mob:Human {
    let name: String? = nil     // プロパティで定数で実装、プロコトルはvar、getでも、let、setで定義できる
    init() { }                  // イニシャライザは何もしない
    func sayHello(to: Human) {
        print("どうも")            // 実装を書く
    }
    func cheer() { print("頑張れ")}  // Humanには存在しないメソッドも定義できる
}

//// データ型としてのプロトコル
//func printName(list:[Human]) {
//    for p in list {
//        print((p.name ?? "名無し") + "さん")
//        p.cheer()   // この呼び出しはできない
//        // プロトコルHUmanにある機能しか使えない
//    }
//}

// List5-5 プロトコルStaff
protocol Staff:Human { // プロトコルを継承
    var title: String{ get set } // 読み書き可能なプロパティ
}

// List5-6 プロトコルHumanとStaffの両方で宣言されたメソッド、プロパティを使う
