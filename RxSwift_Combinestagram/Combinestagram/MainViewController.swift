/// Copyright (c) 2020 Razeware LLC
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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import RxSwift
import RxRelay

class MainViewController: UIViewController {

  // ここで宣言すると、UIViewControllerのライフサイクルで Disposeされるようになる。
  private let bag = DisposeBag()
  // BehaviorRelayは、BehaviorSubjectをラップしている
  // 初期値で作成され、新しいサブスクライバーにその最新値または初期値を再生。
  // observableとobserverの両方の役割を果たします
  private let images = BehaviorRelay<[UIImage]>(value: [])
  
  @IBOutlet weak var imagePreview: UIImageView!
  @IBOutlet weak var buttonClear: UIButton!
  @IBOutlet weak var buttonSave: UIButton!
  @IBOutlet weak var itemAdd: UIBarButtonItem!

  override func viewDidLoad() {
    super.viewDidLoad()

    // ここでのonNextは、imageが発する.nextイベントをサブスクライブすること
    // imagePreviewは、46行目のUIImageViewのこと、ここで画像に変化があったときだけイベントをつけるようにしている
    images.subscribe(onNext: {[weak imagePreview] photos in
      print("==== subscribe1")
      // 画像があるときだけ処理する
      guard let preview = imagePreview else { return }
      print("==== preview is not null")
      // collageは独自のメソッド
      preview.image = photos.collage(size: preview.frame.size)
    })
    // この購読をViewControllerのdisposeバックに追加
      .disposed(by: bag)
    
    // この画像が追加される、imagesを監視している
    images.subscribe(onNext: { [weak self] photos in
      print("==== subscribe2")
      self?.updateUI(photos:photos)
    })
      .disposed(by: bag)
  }
  
  private func updateUI(photos: [UIImage]) {
    buttonSave.isEnabled = photos.count > 0 && photos.count % 2 == 0
    buttonClear.isEnabled = photos.count > 0
    itemAdd.isEnabled = photos.count < 6
    title = photos.count > 0 ? "\(photos.count) photos" : "Collage"
  }
  
  @IBAction func actionClear() {
    images.accept([])
  }

  @IBAction func actionSave() {
    guard let image = imagePreview.image else { return }
    
    // 現在のコラージュを保存しています
    PhotoWriter.save(image)
      // 返された Observable を Single に変換
      // サブスクリプションが最大で 1 つの要素を取得するようにする
      .asSingle()
      .subscribe(
        onSuccess: {[weak self] id in
          self?.showMessage("Saved with id:\(id)")
          // 書き込み操作が成功した場合、現在のコラージュをクリア
          self?.actionClear()
        },
        onError: { [weak self] error in
          self?.showMessage("Error", description: error.localizedDescription)
        }
      )
      .disposed(by: bag)
  }

  // images リレーの初期値は空の配列で、ユーザーが + ボタンをタップするたびに、
  // images が生成する observable sequence は新しい配列を要素とする
  // 新しい .next イベントを発行します。
  @IBAction func actionAdd() {
//    // value：behavior subjectの現在値を取得、そして画像をもう一枚追加
//    let newImages = images.value + [UIImage(named: "IMG_1907.jpg")!]
//    // イベント`を受け取り、それをサブスクライバーに発行する。
//    // メソッド内で「 self._subject.onNext(event)」が発行されている
//    images.accept(newImages)
    
    
    // navigationControllerを使って、PhotosViewControllerのボードに遷移
    let photosViewController = storyboard!.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
    
    // selectedPhotos observableのイベントをサブスクライブします。
    photosViewController.selectedPhotos
      .subscribe(
        onNext: {[weak self] newImage in
          guard let images = self?.images else { return }
          // イベント`を受け取り、それをサブスクライバーに発行する。
          // selectedPhotosとは別のObserverであるimagesにイベント発行する
          // selectedPhotosとimagesのオブザーバーは関係がなくて、
          // このように他のオブザーバーを購読した場所で
          // 別のオブザーバーにイベント発行することもできる
          images.accept(images.value + [newImage])
        },
        onDisposed: {
          print("Completed photo selection")
        })
      .disposed(by: bag)

    navigationController!.pushViewController(photosViewController, animated: true)
    
  }

  func showMessage(_ title: String, description: String? = nil) {
    let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
    present(alert, animated: true, completion: nil)
  }
}
