//: [Previous](@previous)
import Foundation
import Combine

/*:
# 件名
- Subject（サブジェクト）とは，発行者ｍ（パブリッシャー）のことである．
- ... 他のパブリッシャーから受け取った値を中継（relay）する ...
- ... 手動で新しい値を与えることができる
- ... Subject（サブジェクト）は購読者（subscribers）でもあり、`subscribe(_:)` と共に使用することができます。
*/

/*:
## Example 1
サブジェクトを利用して、購読者（subscribers）に値（values）をリレー（relay）する。
*/
// PassthroughSubject
// https://developer.apple.com/documentation/combine/passthroughsubject
// PassthroughSubjectはCurrentValueSubjectとは異なり値を保持しません。
// 値を保持する必要なく毎回データを更新（上書き）するような場合はPassthroughSubjectを使うと良いです。
// subjectは、Subjectの外部から値を受け取り、通知するもの
let relay = PassthroughSubject<String, Never>()

// 購読者（subscribers）を定義
let subscription = relay
	.sink { value in
		print("subscription1 received value: \(value)")
}

// 購読者（subscribers）に値を送信します。
relay.send("Hello")
relay.send("World!")

//: 購読 （subscription）の設定前に "hello "を送信するとどうなるのでしょうか？

/*:
## Example 2
 subjectを発行者（publisher）にSubscribingする
*/

let publisher = ["Here","we","go!"].publisher

publisher.subscribe(relay)

/*:
## Example 3
 最新の値を保持し、新しい購読者（subscribers）にリレー（relay）するために `CurrentValueSubject` を使用する。
 CurrentValueSubject：
 https://developer.apple.com/documentation/combine/currentvaluesubject
 1つの値をラップし、値が変わるたびに新しい要素を公開するサブジェクト。
*/

// Never：
// 無条件にエラーを投げる、トラップする、あるいは終了しないクロージャ、関数、メソッドを宣言するときは、戻り値の型としてNeverを使用します。
// ("")は初期値
let variable = CurrentValueSubject<String, Never>("")

variable.send("Initial text")

let subscription2 = variable.sink { value in
	print("subscription2 received value: \(value)")
}

variable.send("More text")
//: [Next](@next)
