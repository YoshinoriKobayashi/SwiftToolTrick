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
struct Employee : Staff { // プロトコルStaffを採用
    let name: String? // Humanプロトコル
    var title: String = "" // Staffプロトコル
    func sayHello(to p: Human) { // Humanプロトコル
        let s = "ご苦労様です"
        if let who = p.name { s + "、" + who + "さん"}
    }
}

// List 5-7 プロトコルHumanに適合する構造体Student
protocol FullName {
    var lastname: String{ get } //　苗字
    var firstname: String { get }  // 名前
}

struct Student: Human, FullName {
    let lastname: String
    let firstname: String
    var name: String? {  // 計算型プロパティで実装
        return lastname + firstname //FullName　プロトコル
    }
    func sayHello(to p: Human) {
        let s = "こんにちは"
        if let who = p.name { s + "、" + who + "さん"}
        print(s)
    }

}

var a  = Mob()
var b = Employee(name: "安岡", title: "ボディガード")
var c = Student(lastname: "夏川", firstname: "真鍋")
a.sayHello(to: b)
b.sayHello(to: c)
c.sayHello(to: a)

// List5-8プロコトルに付属型を宣言
protocol SimpleVector {
    associatedtype Element      // 付属型（ジェネリクス）
    var x : Element { get set } // Elementが型パタメータ
    var y : Element { get set } // コンパイル時に型がわりあて
}

// List5-9 付属型のあるプロトコルの利用例
struct VectorFloat: SimpleVector {
    // プロトコル付属型ElementはFloat型であることを、typealiasを使って明示
    typealias Element = Float
    var x, y: Float
}
// VectorDoubleをコンパイルしたときに型がきまる
struct VectorDouble:SimpleVector,CustomStringConvertible {
    var x,y:Double

    // プロトコルとプロパティの定義からDouble型と判断

    var description: String {return "[\(x), \(y)]"}
    // Double型の代わりにElementでも動作する
    init(x: VectorDouble.Element, y:VectorDouble.Element) {
        // 付属型を型として使うことも可能
        self.x = x;self.y = y
    }
    init(vectorFloat d: VectorFloat) {
        //プロトコルの付属型を参照するときは、型.付属型になる。プロトコル.付属型ではないので注意！
        self.init(x: Double(d.x),y:Double(d.y))
    }
}
struct VectorGrade : SimpleVector,CustomStringConvertible {

    // ネスト型を定義
    // 付属型を列挙型でその場で直接に定義
    enum Element: String{ case A,B,C,D,X}

    var x,y: Element
    var description: String {return "[\(x),\(y)]"}

}
//実行例
var aa = VectorFloat(x: 10.0, y: 12.9)
let bb = VectorDouble(vectorFloat: aa)
print(bb) // [10.0, 12.9]と表示される
var gg = VectorGrade(x: .A, y: .C)
print(gg) // [A,C]と表示される

// SimpleVectorのプロパティx,yが、Float型、Double型、String型として使えている
