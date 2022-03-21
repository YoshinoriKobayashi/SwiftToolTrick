//
//  GitHubSignupViewController1.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 4/25/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GitHubSignupViewController1 : ViewController {
    // ViewControllerの実装1
    // @IBOutletをViewControllerに接続
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidationOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidationOutlet: UILabel!
    
    @IBOutlet weak var repeatedPasswordOutlet: UITextField!
    @IBOutlet weak var repeatedPasswordValidationOutlet: UILabel!
    
    @IBOutlet weak var signupOutlet: UIButton!
    @IBOutlet weak var signingUpOulet: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // ViewControllerの実装2、ViewModelを初期化
        // 役割2:ViewModelを初期化する
        // 役割3：ViewModelの出力とUIコンポーネントをバインドする
        let viewModel = GithubSignupViewModel1(
            // Obserbvableを渡す、ストリーム
            input: (
                // ViewControllerの実装2_1
                username: usernameOutlet.rx.text.orEmpty.asObservable(),
                password: passwordOutlet.rx.text.orEmpty.asObservable(),
                repeatedPassword: repeatedPasswordOutlet.rx.text.orEmpty.asObservable(),
                loginTaps: signupOutlet.rx.tap.asObservable()
            ),
            dependency: (
                API: GitHubDefaultAPI.sharedAPI,
                validationService: GitHubDefaultValidationService.sharedValidationService,
                wireframe: DefaultWireframe.shared
            )
        )

        // ViewControllerの実装3.ViewModelのアウトプットからViewにbind
        // ViewControllerの実装3_1
        // 役割3.ViewModelの出力とUIコンポーネントをバインドする
        viewModel.signupEnabled
            .subscribe(onNext: { [weak self] valid  in
                self?.signupOutlet.isEnabled = valid
                self?.signupOutlet.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)

        // ViewControllerの実装3_2
        viewModel.validatedUsername
            .bind(to: usernameValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)

        viewModel.validatedPassword
            .bind(to: passwordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)

        viewModel.validatedPasswordRepeated
            .bind(to: repeatedPasswordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)

        viewModel.signingIn
            .bind(to: signingUpOulet.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.signedIn
            .subscribe(onNext: { signedIn in
                print("User signed in \(signedIn)")
            })
            .disposed(by: disposeBag)
        //}

        // ViewControllerの実装4 画面をタップされるジェスチャーを設定
        // 入力モードを終了して、ソフトフェアキーボードを閉じる
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
    }
}
