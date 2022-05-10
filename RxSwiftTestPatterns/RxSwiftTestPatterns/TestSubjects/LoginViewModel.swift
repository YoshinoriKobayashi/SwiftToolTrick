import RxSwift
import RxCocoa

/*
Subject/Relay
私はViewModelで状態を保持するプロパティの型としてBehaviorRelayをよく使います。
UITextField等のUIをバインドし、何らかのロジックを実行してUIに結果を反映させるという使い方です。

ここではHotObservable + scheduleAt + startパターンを使用した例をご紹介します。

なお、ここで紹介するテストコードの書き方は、同じRelayのPublishRelayや、PublishSubject、BehaviorSubjectなどのSubjectでも使えます。
*/

class LoginViewModel {
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    //isValidEmailのテスト
    //LoginViewModelのemailプロパティは、ビューのUITextFieldにバインドされることを想定しています。
    //そして、ビュー側ではisValidEmailをサブスクライブし、文字が入力されるたびにそのフィールドが有効かどうかをユーザにフィードバックするというイメージです。
    var isValidEmail: Driver<Bool> {
        return email.asDriver().map { !$0.isEmpty }
    }

    //isValidFormのテスト
    //isValidFormは、emailとpassword両方が有効な場合のみtrueを返します。
    //isValidFormはビューのUIButton.rx.isEnabledにバインドし、
    //ユーザがログインフォームに文字を入力するたびにフォームが評価され、
    //ボタンがリアクティブに有効になったり無効になったりするというような使い方を想定しています。
    var isValidPassword: Driver<Bool> {
        return password.asDriver().map { !$0.isEmpty }
    }
    
    var isValidForm: Driver<Bool> {
        return Driver.combineLatest(isValidEmail, isValidPassword).map { $0 && $1 }
    }
}
