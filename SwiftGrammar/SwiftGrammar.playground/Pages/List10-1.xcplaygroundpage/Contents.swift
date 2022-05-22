//: [Previous](@previous)

import Foundation

// Stringに全角文字が含まれていたら、ASCII文字に変換する
extension String {
    // 文字列がすべて0x20〜0x7eの間のASCII文字だったときにtureになるプロパティ
    var isHankaku: Bool {
        // 文字コードを順番に調査
        for ch in self.unicodeScalars {
            if !(0x20 ..< 0x7F ~= ch.value) { return false }
            return true
        }
        return false
    }
    static var zenSpaceDouble: Bool = true // 全角空白を2つの半角空白にする

    func toHankaku() -> String {
        var r = ""
        for ch in self.unicodeScalars {
            var v = ch.value  // 文字コードを得る
            switch v {
            case 0xFF01 ..< 0xFF5F:                         // 全角文字
                v -= 0xff01 - 0x21                          // ASCII文字にする

                // 文字コードはUnicode.Scalar型のビューから取り出し、値はUInt32
                r.unicodeScalars.append(Unicode.Scalar(v)!) // ビューを変更
            case 0x3000:  // 全角空白
                r += String.zenSpaceDouble ? "　" : "  "
            default:
                r.unicodeScalars.append(ch)                 // ビューを変更
            }
        }
        return r
    }

}
let orig = "Ａｓｕｋａ\u{3000}2001年12月０４日"
print(orig.isHankaku)
print("2001-12-04".isHankaku)
print("2001-12-04".unicodeScalars)
print(orig.unicodeScalars)
String.zenSpaceDouble = false
print(orig.toHankaku())
print(Int("１５４９８".toHankaku())! + 34) // 15532
