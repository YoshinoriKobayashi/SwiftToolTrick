//: [Previous](@previous)

import Foundation

// List5-16 プロトコルComparableを採用した構造体Timeの定義
struct Time: Comparable, CustomStringConvertible{
    let hour,min: Int   // 定数で時刻を保持。全項目イニシャライザを使う

    // == の条件はhourとminが同じとき、==の条件を作れる
    static func ==(lhs: Time, rhs: Time) -> Bool {
        return lhs.hour == rhs.hour && lhs.min == rhs.min
    }
    // 時間が大きいときの条件
    static func < (lhs: Time, rhs: Time) -> Bool {
        return lhs.hour < rhs.hour || (lhs.hour == rhs.hour && lhs.min < rhs.min)
    }

    // 表示のため
    var description: String {
        let h = hour < 10 ? "\(hour)" : "\(hour)"
        let m = hour < 10 ? "0\(min)" : "\(min)"
        return h + ":" + m
    }



}
let t1 = Time(hour:9, min:0)
let t2 = Time(hour:12, min:30)
let t3 = Time(hour:12, min:15)
print(t1 != t2)
print(t1 > t3)
print([t1,t2,t3].sorted()) // [9:00, 12:15, 12:30]
