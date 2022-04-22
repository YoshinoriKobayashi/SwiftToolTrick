//: [Previous](@previous)
import Foundation
import Combine

/*:
# 件名
- サブジェクトとは，パブリッシャーのことである．
- ... 他のパブリッシャーから受け取った値を中継する ...
- ... 手動で新しい値を与えることができる
- ... サブジェクトは購読者でもあり、`subscribe(_:)` と共に使用することができます。
*/

/*:
## Example 1
サブジェクトを利用して、購読者（subscribers）に値（values）をリレー（relay）する。
*/
// PassthroughSubject
// https://developer.apple.com/documentation/combine/passthroughsubject
// PassthroughSubjectはCurrentValueSubjectとは異なり値を保持しません。
// 値を保持する必要なく毎回データを更新（上書き）するような場合はPassthroughSubjectを使うと良いです。
let relay = PassthroughSubject<String, Never>()

let subscription = relay
	.sink { value in
		print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")

//: What happens if you send "hello" before setting up the subscription?
//: 購読の設定前に "hello "を送信するとどうなるのでしょうか？

/*:
## Example 2
Subscribing a subject to a publisher
 サブジェクトをパブリッシャーにサブスクライブする
*/

let publisher = ["Here","we","go!"].publisher

publisher.subscribe(relay)

/*:
## Example 3
Using a `CurrentValueSubject` to hold and relay the latest value to new subscribers
 最新の値を保持し、新しい購読者にリレーするために `CurrentValueSubject` を使用する。
*/

let variable = CurrentValueSubject<String, Never>("")

variable.send("Initial text")

let subscription2 = variable.sink { value in
	print("subscription2 received value: \(value)")
}

variable.send("More text")
//: [Next](@next)
