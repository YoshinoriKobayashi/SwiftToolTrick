//
//  Protocols.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import RxSwift
import RxCocoa

// ViewControllerおよびViewModelで使われるValidationResultは、
// このサンプル用のenumで複数あるバリデート処理結果のパターンを表現します。
enum ValidationResult {
    case ok(message: String)    // 問題なし
    case empty                     // 入力が空
    case validating                 // バリデート中
    case failed(message: String)    // 失敗
}

enum SignupState {
    case signedUp(signedUp: Bool)
}

protocol GitHubAPI {
    func usernameAvailable(_ username: String) -> Observable<Bool>
    func signup(_ username: String, password: String) -> Observable<Bool>
}

protocol GitHubValidationService {
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

