import Foundation
import Combine

/*:
 # パブリッシャーとサブスクライバー
 - パブリッシャーが値を公開する ...
 - ... サブスクライバーはパブリッシャーの値を受け取るために _subscribes_ します。

 __Specifics__:
 - Publishers are _typed_ to the data and error types they can emit
 - A publisher can emit, zero, one or more values and terminate gracefully or with an error of the type it declared.
 - パブリッシャーは、発行できるデータとエラーの種類に_タイプされている
 - パブリッシャーは 0 個、1 個、または複数の値を出力し、宣言した型のエラーで 優雅に終了することが出来ます。 */
/*:
## Example 1
"publish" just one value then complete
 1つの値だけを「公開」して完了
 */
let publisher1 = Just(42)

// You need to _subscribe_ to receive values (here using a sink with a closure)
// 値を受け取るには_subscribe_が必要（ここではクロージャを持つシンクを使用）。
let subscription1 = publisher1.sink { value in
	print("Received value from publisher1: \(value)")
}

/*:
## Example 2
"publish" a series of values immediately
 値を連ねる
 */
let publisher2 = [1,2,3,4,5].publisher

let subscription2 = publisher2
    .sink { value in
        print("Received value from publisher2: \(value)")
    }


/*:
## Example 3
assign publisher values to a property on an object
 オブジェクトのプロパティにパブリッシャー値を割り当てる
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
let subscription3 = publisher2.assign(to: \.property, on: object)

//: [Next](@next)
