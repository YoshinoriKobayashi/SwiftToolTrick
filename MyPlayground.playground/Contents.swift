import UIKit
//Foundation
import Foundation

//日付を取得
let day = Date()

//【処理】
//   日の加算
//【引数】
//   byAdding: .day（日単位で加算したいのでday指定【列挙型】）
//   value: 1（1日加算）
//   to: day（開始日）
//【戻り値】
//   算出後の日付
let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: day)!

print("day          : \(day)")
print("modifiedDate : \(modifiedDate)")
