//: [Previous](@previous)

import Foundation

class FileAttribute {
    let filename: String
    // 遅延評価で値を決定
    lazy var size: Int = {
        var buffer = stat()         // 構造体の初期化
        stat(filename, &buffer)     // statを呼び出す
        print("[getFileSize]")      // 動作確認のための印字
        return Int(buffer.st_size)  // 得られた値をInt型に変換
    }()
    init(file: String) {
        filename = file
    }
}

let d = FileAttribute(file:"text.txt")
print(d.filename)
print(d.size)
print(d.size)
