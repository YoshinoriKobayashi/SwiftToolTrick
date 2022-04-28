//
//  PeaksiOSTesting03Tests.swift
//  PeaksiOSTesting03Tests
//
//  Created by kobayashi on 2022/04/27.
//

import XCTest
@testable import PeaksiOSTesting03

class PeaksiOSTesting03Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // ③"test"はじまりの命名
    // ④日本語で名付けられたテストケース名。句読点は利用できないため、_で代用
    func test数字が2文字含まれており_合計7文字入力された場合にfalseが返されること() {
        // ⑤"XCTAssert" の頭文字で始まるXCTestのアサーションメソッド
        XCTAssertFalse(validate(password: "abcde12"))
    }



}
