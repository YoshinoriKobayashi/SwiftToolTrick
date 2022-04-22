import Foundation
import Combine

/*:
 # パブリッシャーとサブスクライバー
 - パブリッシャーが値を公開する ...
 - ... サブスクライバーはパブリッシャーの値を受け取るために _subscribes_ します。

 具体的な内容:
 - Publishers are _typed_ to the data and error types they can emit
 - A publisher can emit, zero, one or more values and terminate gracefully or with an error of the type it declared.
 - パブリッシャーは、発行できるデータとエラーの種類に_タイプされている
 - パブリッシャーは 0 個、1 個、または複数の値を出力し、宣言した型のエラーで 優雅に終了することが出来ます。 */
/*:
## Example 1
 1つの値だけを「publish」して完了
 */
let publisher1 = Just(42)

// 値を受け取るには_subscribe_が必要（ここではクロージャを持つsinkを使用）。
// sink(receiveValue:) はストリームが失敗しない場合、つまりPublisherのFailureタイプがNeverの場合にのみ使用できます。
let subscription1 = publisher1.sink { value in
	print("Received value from publisher1: \(value)")
}

/*:
## Example 2
 publishで値を連ねる
 */
let publisher2 = [1,2,3,4,5].publisher

let subscription2 = publisher2
    .sink { value in
        print("Received value from publisher2: \(value)")
    }

/*:
## Example 3
 オブジェクトのプロパティにpublisher値を割り当てる
 */
print("")
class MyClass {
	var property: Int = 0 {
		didSet {
			print("Did set property to \(property)")
		}
	}
}

let object = MyClass()
// assign(to:on:)
// https://developer.apple.com/documentation/combine/publisher/assign(to:on:)
// Publisherから流れてくるデータをオブジェクトにバインディング（代入）する時に使う
let subscription3 = publisher2.assign(to: \.property, on: object)

//: [Next](@next)
