import Foundation
import RxSwift
import RxCocoa
import PlaygroundSupport
import UIKit

let disposeBag = DisposeBag()

let relay = PublishRelay<String>()

relay.subscribe(onNext: {
    print("\($0)")
})
relay.accept("Hello")
relay.accept("RxSwift")
relay.accept("World")
