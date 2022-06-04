//: [Previous](@previous)

import Foundation

// List13-3 プロトコルによる制約のあるジェネリック関数の例

//public protocol Comparable: Equatable {
//    public static func < (lhs: Self,　rhs: Self) -> Bool
//    public static func <= (lhs: Self,　rhs: Self) -> Bool
//    public static func >= (lhs: Self,　rhs: Self) -> Bool
//    public static func > (lhs: Self,　rhs: Self) -> Bool
//
//}

struct Time: Comparable, CustomStringConvertible {
    let hour,min: Int     // 定数で時刻を保持。全項目イニシャライザを使う
    static func ==(lhs: Time, rhs: Time) -> Bool {
        return lhs.hour == rhs.hour && lhs.min == rhs.min
    }
    static func <(lhs: Time, rhs: Time) -> Bool {
        return lhs.hour < rhs.hour || (lhs.hour == rhs.hour && lhs.min < rhs.min)
    }
    var description : String {
        let h = hour < 10 ? "\(hour)" : "\(hour)"
        let m = min < 10 ? "0\(min)" : "\(min)"
        return h + ":" + m
    }
}


//func mySwap<T: Comparable>(little a: inout T, great b: inout T) {
// 関数定義では、適合すべきプロトコルの条件を型パラメータと分けて、where節として記述することもできる
func mySwap<T>(little a: inout T, great b: inout T) where T: Comparable {
    if a > b {
        let t = a; a = b; b = t
    }
}

var meeting = Time(hour:13, min:30)
var lunch = Time(hour:12, min:0)
mySwap(little: &meeting, great: &lunch)
print(meeting)

