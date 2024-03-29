//
//  GithubSignupViewModel1.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import RxSwift
import RxCocoa

/**
This is example where view model is mutable. Some consider this to be MVVM, some consider this to be Presenter,
 or some other name.
 In the end, it doesn't matter.
 
 If you want to take a look at example using "immutable VMs", take a look at `TableViewWithEditingCommands` example.
 
 This uses vanilla rx observable sequences.
 
 Please note that there is no explicit state, outputs are defined using inputs and dependencies.
 Please note that there is no dispose bag, because no subscription is being made.
*/
class GithubSignupViewModel1 {
    // outputs {

    // ViewModelの実装1 出力としてのプロパティを宣言
    // サインアップ用に入力されたユーザ名のバリデート結果をストリームとしており、ValidationResultをイベントとして伝えます
    // ViewControllerおよびViewModelで使われるValidationResultは、
    // このサンプル用のenumで複数あるバリデート処理結果のパターンを表現します
    // ValidationResultは、列挙体のステータス
    let validatedUsername: Observable<ValidationResult>
    
    let validatedPassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>

    // Is signup button enabled
    // バリデート結果に問題なくサインアップできることを伝えるためのストリームとなります。
    // 結果は2パターンで表現力を必要としないのでBoolになっているわけです。
    let signupEnabled: Observable<Bool>

    // Has user signed in
    let signedIn: Observable<Bool>

    // Is signing process in progress
    let signingIn: Observable<Bool>

    // }

    // 役割1.API用のロジックなどをイニシャライザで外部から用意できるようにする
    init(input: (
            username: Observable<String>,
            password: Observable<String>,
            repeatedPassword: Observable<String>,
            loginTaps: Observable<Void>
        ),
        dependency: (
            API: GitHubAPI,
            validationService: GitHubValidationService,
            wireframe: Wireframe
        )
    ) {
        let API = dependency.API
        let validationService = dependency.validationService
        let wireframe = dependency.wireframe

        /**
         Notice how no subscribe call is being made. 
         Everything is just a definition.

         Pure transformation of input sequences to output sequences.
        */

        // ViewModelの実装2 イニシャライザで
        // Observableをsubscribeせず出力へ変換している
        // 実装2_2
        // 役割2：イニシャライザで受け取ったObservableを処理して出力に変換
        validatedUsername = input.username
            .flatMapLatest { username in
                return validationService.validateUsername(username)
                    .observe(on:MainScheduler.instance)
                    .catchAndReturn(.failed(message: "Error contacting server"))
            }
            .share(replay: 1)

        // ViewModelの実装2_1
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
            }
            .share(replay: 1)

        // ViewModelの実装2_3
        validatedPasswordRepeated = Observable.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)
            .share(replay: 1)

        let signingIn = ActivityIndicator()
        self.signingIn = signingIn.asObservable()

        // ViewModelの実装2_4
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) { (username: $0, password: $1) }

        // ViewModelの実装2_5
        signedIn = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in
                return API.signup(pair.username, password: pair.password)
                    .observe(on:MainScheduler.instance)
                    .catchAndReturn(false)
                    .trackActivity(signingIn)
            }
            .flatMapLatest { loggedIn -> Observable<Bool> in
                let message = loggedIn ? "Mock: Signed in to GitHub." : "Mock: Sign in to GitHub failed"
                return wireframe.promptFor(message, cancelAction: "OK", actions: [])
                    // propagate original value
                    .map { _ in
                        loggedIn
                    }
            }
            .share(replay: 1)
        
        signupEnabled = Observable.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated,
            signingIn.asObservable()
        )   { username, password, repeatPassword, signingIn in
                username.isValid &&
                password.isValid &&
                repeatPassword.isValid &&
                !signingIn
            }
            .distinctUntilChanged()
            .share(replay: 1)
    }
}
