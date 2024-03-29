//: [Previous](@previous)

import Combine
import UIKit

/*:
 ## 購読（Subscription）の詳細
 - 購読者（subscriber）は、_single_ subscriptionを受け取ります。
 - ゼロまたはそれ以上の値を公開することができる
 - 最大で_one_ {completion, error}が呼び出されます。
 - 完了後、それ以上何も受信しない
 */

enum ExampleError: Swift.Error {
    case somethingWentWrong
}

let subject = PassthroughSubject<String, ExampleError>()

// The handleEvents operator lets you intercept
// All stages of a subscription lifecycle
// handleEvents オペレータを使用すると、次のようなインターセプトが可能になります。
// サブスクリプションのライフサイクルのすべての段階
subject.handleEvents(receiveSubscription: { (subscription) in
        print("New subscription!")
    }, receiveOutput: { _ in
        print("Received new value!")
    }, receiveCompletion: { _ in
        print("A subscription completed")
    }, receiveCancel: {
        print("A subscription cancelled")
    })
    .replaceError(with: "Failure")
    .sink { (value) in
        print("Subscriber received value: \(value)")
    }

subject.send("Hello!")
subject.send("Hello again!")
subject.send("Hello for the last time!")
subject.send(completion: .failure(.somethingWentWrong))
subject.send("Hello?? :(")

//: [Next](@next)
