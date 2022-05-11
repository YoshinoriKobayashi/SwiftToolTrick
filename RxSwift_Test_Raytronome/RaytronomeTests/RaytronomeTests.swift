/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
import RxCocoa
import RxSwift
import RxTest
import RxBlocking

@testable import Raytronome
import CoreMIDI

class RaytronomeTests: XCTestCase {
  var viewModel: MetronomeViewModel!

  var scheduler: TestScheduler!
  var disposeBag: DisposeBag!

  override func setUp() {
    viewModel = MetronomeViewModel()

    // TestScheduler のイニシャライザーは、ストリームの「開始時間」を定義する initialClock 引数を取ります
    scheduler = TestScheduler(initialClock: 0)
    // DisposeBag が、前のテストによって残されたサブスクリプションを削除
    disposeBag = DisposeBag()
  }

  // RxBlocking の演算子は throw するかもしれないので、テストメソッドのシグネチャに throws が含まれていることに注意してください
  func testNumeratorStartAt4() throws {
    // toBlocking() で通常のストリームを BlockingObservable に変換
    // first() で最初に出力される要素を待ち、それを返します
    // XCTAssertEqual：2つの記録済みイベントのリストが等しいことを表明する。
    XCTAssertEqual(try viewModel.numeratorText.toBlocking().first(), "4")
    XCTAssertEqual(try viewModel.numeratorValue.toBlocking().first(), 4)
  }

  func testDenominatorStartsAt4() throws {
    XCTAssertEqual(try viewModel.denominatorText.toBlocking().first(), "4")
  }

  func testSignatureStartAtBy4() throws {
    XCTAssertEqual(try viewModel.signatureText.toBlocking().first(), "4/4")
  }
  func testTempoStartsAt120() throws {
    XCTAssertEqual(try viewModel.tempoText.toBlocking().first(), "120 BPM")
  }

  // 最初のテストでは、Play/Pause ボタンを数回トリガーし、isPlaying 出力がそれに応じて変化することを確認します。
  func testTappedPlayPauseChangeIsPlaying() {
    // TestScheduler を使って、モックにしたい要素 (この場合は Bool)
    // の TestableObserver を作成します。
    // この特別なオブザーバの主な利点のひとつは、
    // eventsプロパティを公開し、それに追加されたイベントを
    // アサートするために使用できることです。
    let isPlaying = scheduler.createObserver(Bool.self)

    // drive() で isPlaying の出力を新しい TestableObserver に取り込みます。ここでイベントを "記録 "します。
    viewModel.isPlaying
      .drive(isPlaying)
      .disposed(by: disposeBag)

    // これがInputになる
    // tappedPlayPause入力への3回の「タップ」を模倣した
    // モックObservableを作成します。
    // これもTestableObservableと呼ばれる
    // 特殊なObservableで、TestSchedulerを使って、
    // 指定された仮想時間にイベントを発生させます。
    scheduler.createColdObservable(
      [.next(10,()),
       .next(20, ()),
      .next(30, ())])
        .bind(to: viewModel.tappedPlayPause)
        .disposed(by: disposeBag)

    // TestSchedulerで start() を呼び出します。このメソッドは、
    // 前のポイントで作成された保留中のサブスクリプションをトリガーします。
    scheduler.start()

    // これがOutputになる
    // RxTestにバンドルされているXCTAssertEqualの特別なオーバーロードを使用して、
    // isPlayingのイベントが、要素および時間の両方において、
    // 期待するものと等しいことを表明できます。
    // 10、20、30は入力が発生した時間に対応し、0はisPlayingの初期放出です。
    XCTAssertEqual(isPlaying.events, [
      .next(0, false),
      .next(10, true),
      .next(20, false),
      .next(30, true)
    ])
  }

  //イベントのストリームを「モック」し、
  //それを特定のタイミングでビューモデルの入力に送り込みます。
  //そして、出力が正しい時刻に期待通りのイベントを
  //出力していることを確認するために、出力をアサーションします。
  //（この手順が重要）

  // 分子を変更したとき、テキストが正しく更新されるかどうかをテストします。
  func testModifyingNumeratorUpdatesNumeratorText() {
    let numerator = scheduler.createObserver(String.self)

    viewModel.numeratorText
      .drive(numerator)
      .disposed(by: disposeBag)

    scheduler.createColdObservable([.next(10,3),.next(15, 1)])
      .bind(to: viewModel.steppedNumerator)
      .disposed(by: disposeBag)

    scheduler.start()

    XCTAssertEqual(numerator.events, [
      .next(0, "4"),
      .next(10, "3"),
      .next(15, "1")
    ])
  }

  // 分子を変更した際に、テキストが正しく更新されるかどうかを調べます。
  func testModifyingDenominatorUpdatesNumeratorText() {
    let denominator = scheduler.createObserver(String.self)

    viewModel.denominatorText
      .drive(denominator)
      .disposed(by: disposeBag)

    // Denominator is 2 to the power of `steppedDenominator + 1`.
    // f(1, 2, 3, 4) = 4, 8, 16, 32
    scheduler.createColdObservable([.next(10, 2),
                              .next(15, 4),
                              .next(20, 3),
                              .next(25, 1)])
    .bind(to: viewModel.steppedNumerator)
    .disposed(by: disposeBag)

    scheduler.start()

    XCTAssertEqual(denominator.events, [
      .next(0, "4"),
      .next(10, "8"),
      .next(15, "32"),
      .next(20, "16"),
      .next(25, "4"),
    ])
  }

  // テンポを変更したときにテキストが正しく更新されるかどうかをテストします。
  func testModifyingTempoUpdatesTempoText() {
    let tempo = scheduler.createObserver(String.self)

    viewModel.tempoText
      .drive(tempo)
      .disposed(by: disposeBag)

    scheduler.createColdObservable([.next(10, 75),
                              .next(15, 90),
                              .next(20, 180),
                              .next(25, 60)])
    .bind(to: viewModel.tempo)
    .disposed(by: disposeBag)

    scheduler.start()

    XCTAssertEqual(tempo.events, [
      .next(0, "120 BPM"),
      .next(10, "75 BPM"),
      .next(15, "90 BPM"),
      .next(20, "180 BPM"),
      .next(25, "60 BPM"),
    ])
  }

  func testModifyingSignatureUpdatesSignatureText() {

    let signature = scheduler.createObserver(String.self)

    viewModel.signatureText
        .drive(signature)
        .disposed(by: disposeBag)

    // Inputs
    scheduler.createColdObservable([.next(5, 3),
                                    .next(10, 1),
                                    .next(20, 5),
                                    .next(25, 7),
                                    .next(35, 12),
                                    .next(45, 24),
                                    .next(50, 32)
                                  ])
    .bind(to: viewModel.steppedNumerator)
    .disposed(by: disposeBag)

    // Inputs
    // Denominator is 2 to the power of `steppedDenominator + 1`.
    // f(1, 2, 3, 4) = 4, 8, 16, 32
    scheduler.createColdObservable([.next(15, 2),
                                    .next(30, 3),
                                    .next(40, 4)])
    .bind(to: viewModel.steppedDenominator)
    .disposed(by: disposeBag)

    scheduler.start()

    // Outputs
    XCTAssertEqual(signature.events, [
      .next(0, "4/4"),
      .next(5, "3/4"),
      .next(10, "1/4"),
      .next(15, "1/8"),
      .next(20, "5/8"),
      .next(25, "7/8"),
      .next(30, "7/16"),
      .next(35, "12/16"),
      .next(40, "12/32"),
      .next(45, "24/32"),
      .next(50, "32/32")
    ])


  }
}
