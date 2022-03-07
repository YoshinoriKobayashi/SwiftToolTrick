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

import Foundation
import UIKit
import Photos
import RxSwift

class PhotoWriter {
  enum Errors: Error {
    case couldNotSavePhoto
  }

  // 写真を保存したいコードに返すobservableを作成
  // save(_:) は Observable<String> を返します。なぜなら、写真を保存した後、作成したアセットのユニークなローカル識別子を1つの要素として発行するからです。
  static func save(_ images: UIImage) -> Observable<String> {
    // Observable.create(_) は新しい Observable を作成
    return Observable.create { observer in
      var savedAssetId: String?
      // performChanges(_:completionHandler:) の最初のクロージャパラメータで、提供された画像からフォトアセットを作成
      PHPhotoLibrary.shared().performChanges({
        // 新しい写真アセットを作成
        let request = PHAssetChangeRequest.creationRequestForAsset(from: images)
        // その識別子を savedAssetId に格納
        savedAssetId = request.placeholderForCreatedAsset?.localIdentifier
        
      }, completionHandler: { success, error in
        // 2番目のクロージャで、アセットIDか.errorイベントを発行
        // 成功の応答が返ってきて、savedAssetIdに有効なアセットIDが含まれていれば
        // 、.nextイベントと.completedイベントを発信
        DispatchQueue.main.async {
          if success, let id = savedAssetId {
            // self.on(.next(element)) のショートハンド
            observer.onNext(id)
            observer.onCompleted()
          } else {
            // エラーが発生した場合は、カスタムエラー
            observer.onError(error ?? Errors.couldNotSavePhoto)
          }
        }
      })
      // 外側のクロージャからDisposableを返す必要がある
      return Disposables.create()
    }
  }

}
