//: [Previous](@previous)

import Foundation
import Combine

// tryMap
// https://developer.apple.com/documentation/combine/fail/trymap(_:)
/*
Combine の tryMap(_:) 演算子は Swift の標準ライブラリの map(_:) と似たような機能を果たします: 上流のパブリッシャーから受け取ったそれぞれの要素をクロージャを使って変換します。tryMap(_:) はある種類の要素から別の種類の要素に変換し、マップのクロージャがエラーをスローしたときにパブリッシングを終了させるために使用します。

次の例では、数値の配列をコレクションベースのパブリッシャーのソースとして 使っています。tryMap(_:) 演算子はパブリッシャーから整数を受け取り、辞書を使って アラビア数字からローマ数字に変換し、String として出力しています。tryMap(_:) のクロージャがローマ数字の検索に失敗した場合、エラーがスローされます。tryMap(_:)演算子はこのエラーをキャッチしてパブリッシングを終了し、エラーをラップしたSubscribers.Completion.failure(_:)を送信します。
*/
struct ParseError: Error {}
func romanNumeral(from:Int) throws -> String {
    let romanNumeralDict: [Int : String] =
        [1:"I", 2:"II", 3:"III", 4:"IV", 5:"V"]
    guard let numeral = romanNumeralDict[from] else {
        throw ParseError()
    }
    return numeral
}
let numbers = [5, 4, 3, 2, 1, 0]
let cancellable = numbers.publisher
    .tryMap { try romanNumeral(from: $0) }
    .sink(
        receiveCompletion: { print ("completion: \($0)") },
        receiveValue: { print ("\($0)", terminator: " ") }
     )

// Prints: "V IV III II I completion: failure(ParseError())"

