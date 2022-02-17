//
//  UnitTestingTests.swift
//  UnitTestingTests
//
//  Created by yoshiiikoba on 2022/02/08.
//

import XCTest

// プロジェクトのメインターゲットにバンドルされているクラスなどにアクセスするためのインポート
// このキーワードでテストターゲットからインポートしたターゲットは、internal のアクセスレベルにあるクラスなどにアクセスすることができます
@testable import UnitTesting

// ユニットテスト用
// XCTestCase は、テストケースを定義していくためのクラスです。
// このクラスにテストケースを定義していくことで、特定のライフサイクルにしたがってXCTest がテストを評価していきます。
class UnitTestingTests: XCTestCase {

// p48
//■ 8文字以上であること
//・数字が2文字含まれており、合計7文字入力された場合にfalse が返されること
//・数字が2文字含まれており、合計8文字入力された場合にtrue が返されること
//・数字が2文字含まれており、合計9文字入力された場合にtrue が返されること
//■ 数字が2文字以上利用されていること
//・数字以外を7文字と、数字が1文字入力された場合にfalse が返されること
//・数字以外を7文字と、数字が2文字入力された場合にtrue が返されること
//・数字以外を7文字と、数字が3文字入力された場合にtrue が返されること
    
    // ■8文字以上であること
    // XCTest で書くテストケースは 数名のはじまりをtest とすることで、テストケースとして判別されます
    // XCTest のテストケースは日本語で名前をつけることができるため、
    // ここではわかりやすさの観点から日本語で命名していきます。
    // また句読点が利用できないので、代わりに_を入れることで代用します
    func test数字が2文字含まれており_合計7文字入力された場合にfalseが返されること() {
        // テスト対象の検証はXCTAssert の頭文字で始まるXCTest のアサーションメソッドを使う
        // 今回はバリデーション関数の戻り値がBool で、その真偽値が期待する結果と等価かを確認したいので、
        // XCTest に定義されているいくつかのアサーションメソッドのうち、
        // XCTAssertTrue XCTAssertFalse の つのアサーションメソッドを使う
        XCTAssertFalse(ContentView.validate(password: "abcde12"))
    }
    
    func 数字が2文字含まれており_合計8文字入力された場合にtrueが返されること() {
        XCTAssertTrue(ContentView.validate(password: "abcdef12"))
    }
    func 数字が2文字含まれており_合計9文字入力された場合にtrueが返されること() {
        XCTAssertTrue(ContentView.validate(password: "abcdefg12"))
    }

    //■ 数字が2文字以上利用されていること
    func test数字以外を7文字と_数字が1文字入力された場合にfalseが返されること() {
        XCTAssertFalse(ContentView.validate(password: "abcdefg1"))
    }
    func test数字以外を7文字と_数字が2文字入力された場合にtrueが返されること() {
        XCTAssertTrue(ContentView.validate(password: "abcdefg12"))
    }
    func test数字以外を7文字と_数字が3文字入力された場合にtrueが返されること() {
        XCTAssertTrue(ContentView.validate(password: "abcdefg123"))
    }

    // XCTContextによる構造化コード
    func testパスワードバリデーションの文字数() {
        XCTContext.runActivity(named: "数字が2文字以上含まれている場合") { _ in 
            XCTContext.runActivity(named: "合計7文字が入力された場合") { _ in 
                XCTAssertFalse(ContentView.validate(password: "abcde12"))
            }
            XCTContext.runActivity(named: "合計8文字が入力された場合") { _ in 
                XCTAssertTrue(ContentView.validate(password: "abcdef12"))
            }
            XCTContext.runActivity(named: "合計9文字が入力された場合") { _ in 
                XCTAssertTrue(ContentView.validate(password: "abcdefg12"))
            }
        }
    }

}
