import RxSwift
import RxCocoa

@testable import RxSwiftTestPatterns
import Quick
import Nimble
import RxTest

class LoginViewModelSpec: QuickSpec {
    override func spec() {
        var scheduler: TestScheduler!
        var loginViewModel: LoginViewModel!

        let disposeBag = DisposeBag()

        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            loginViewModel = LoginViewModel()
        }

        //ここではemailに対して["", a@example.com, ""]をemitするHotObservableをバインドし、
        //isValidEmailは[false, false, true, false]をオブザーバに通知することをテストしようとしています。
        describe("isValidEmail") {
            it("should be true when email is not empty") {
                let xs = scheduler.createHotObservable([
                    Recorded.next(10, ""),
                    Recorded.next(20, "a@example.com"),
                    Recorded.next(30, "")
                ])

                xs.bind(to: loginViewModel.email).disposed(by: disposeBag)

                let observer = scheduler.createObserver(Bool.self)
                loginViewModel.isValidEmail.drive(observer).disposed(by: disposeBag)

                scheduler.start()

                //ここで、時刻0でfalseとなっているのは、
                //BehaviorRelayはオブザーバがサブスクライブしたときに
                //最後の要素をemitする(リプレイする)という性質があるためです。
                expect(observer.events).to(equal([
                    Recorded.next(0, false),
                    Recorded.next(10, false),
                    Recorded.next(20, true),
                    Recorded.next(30, false)
                ]))
            }
        }

        //はじめに、2つのHotObservableを作成し、それぞれLoginViewModelのemailとpasswordにバインドします。
        //次に、オブザーバを作成し、LoginViewModelのisValidFormにサブスクライブさせます。
        //ここで期待しているのは、emailとpassword両方のフィールドが有効なときのみisValidFormがtrueになることです。
        //今回の場合、時刻40のときにどちらのフィールドにも文字が1文字以上入力されている状態になるので、時刻40のときにisValidFormがtrueになります。
        describe("isValidForm") {
            it("should be true when both email and password are valid") {
                let xs1 = scheduler.createHotObservable([
                    Recorded.next(10, ""),
                    Recorded.next(30, "a@example.com"),
                    Recorded.next(50, "")
                ])
                
                let xs2 = scheduler.createHotObservable([
                    Recorded.next(20, ""),
                    Recorded.next(40, "passw0rd"),
                    Recorded.next(60, "")
                ])

                xs1.bind(to: loginViewModel.email).disposed(by: disposeBag)
                xs2.bind(to: loginViewModel.password).disposed(by: disposeBag)
                
                let observer = scheduler.createObserver(Bool.self)
                loginViewModel.isValidForm.drive(observer).disposed(by: disposeBag)
                
                scheduler.start()
                
                expect(observer.events).to(equal([
                    Recorded.next(0, false),
                    Recorded.next(10, false),
                    Recorded.next(20, false),
                    Recorded.next(30, false),
                    Recorded.next(40, true),
                    Recorded.next(50, false),
                    Recorded.next(60, false)
                ]))
            }
        }
    }
}
