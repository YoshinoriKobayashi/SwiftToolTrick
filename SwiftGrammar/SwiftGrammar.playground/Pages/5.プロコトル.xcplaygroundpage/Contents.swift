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

// List5-10 プロコトルでSelfを利用する
protocol TransVector {
    associatedtype Element   // 付属型の宣言
    var x: Element{ get }
    var y: Element{ get }
    func transposed() -> Self  // 自分と同じ型を返す関数
    static func +(lhs: Self, rhs: Self) -> Self  // 同じ型同士の演算
    // Self（Sが大文字は同じデータ型をしめす）
}

struct VectorInt: TransVector, CustomStringConvertible {
    typealias Element = Int  // 付属型にInrtを設定
    let x,y: Int
    func transposed() -> VectorInt {
        return VectorInt(x: self.y, y: self.y)
    }
    static func +(lhs: VectorInt, rhs: VectorInt) -> VectorInt {
        return VectorInt(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    var description: String { return "[\(x), \(y)]"}
}

// List5-11
// Equatableを継承したプロトコル
protocol EqVector: Equatable {
    // 付属型に適合するプロトコルを指定
    associatedtype Element: Equatable

    var x: Element {get set}
    var y: Element {get set}

}

// List5-13 プロコトルEqVectorを採用するLabeledPointとShopOnMapの定義
// EqVectorを採用するとEquatableも採用
struct LabeldPoint : EqVector, CustomStringConvertible {
    var label: String
    // IntはEqutableに適合
    var x, y: Int
    var description: String{ return "[\(x), \(y)]"}
    // Equatableには自動的に適合しているので、演算子==は必要ない
}
struct ShopOnMap: EqVector, CustomStringConvertible {
    // 定義にタプルがある
    var shop: (name: String, comment: String?)
    // FloatはEqutableに適合
    var x,y :Float
    init(_ s: String,N: Float, E: Float,comment: String? = nil) {
        shop = (name:s, comment:comment)
        x = E;y = N //　東経と北緯
    }
    var description: String {
        var r = shop.name + "(N\(y), E\(x))"
        if let msg = shop.comment { r += " " + msg }
        return r
    }
    // Equatableに適合するために必要
    // タプルはEquatableに適合できないので、==を定義する
    static func ==(lhs: ShopOnMap, rhs: ShopOnMap) -> Bool {
        // shop以外のx,yプロパティについてのみ==を定義しているのがポイント
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
// Vector.ElementはInt型
let mx: VectorInt.Element = 10
let a2 = LabeldPoint(label: "A", x: mx, y: 7)
var b2 = LabeldPoint(label: "B", x: 10, y: mx-3)
print(a2 != b2) // trueを表示
b2.label = "A"  // labelを変更
print(a2 == b2) // trueを表示
let shop01 = ShopOnMap("たまや",N:35.030,E:135.769, comment: "美味")
let shop02 = ShopOnMap("餅屋",N:35.030,E:135.769)
print(shop01 == shop02)
print(shop01)
