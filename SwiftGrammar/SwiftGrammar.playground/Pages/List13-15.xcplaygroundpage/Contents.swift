//: [Previous](@previous)

import Foundation

// List13-15
// 型パラメータを持つクラスを定義し、さらにそのクラスを継承して別のクラスを定義することができます。

class GeoPoint<Element> {
    var latitude, longitude; Element           // 緯度、軽度
    required init(lat:Element, lon:Element) {  // 必須イニシャライザ
        self.latitude = lat;  self.longitude = lon
    }
    func toString() -> String { return "\(latitude), \(longitude)"}
}

class GPSPoint<T:FloatingPoint> : GeoPoint<T>, CustomStringConvertible {
    var description: String{ return "GPSPoint: " + toString()}
    override func toString() -> String {    // 実数に適用可能な定義
        let ns = latitude.sign == .plus     // latitude >= 0.0 はエラー
            ? "N\(latitude)" : "S\(-latitude)"  // 北緯と南緯
        let ew = longitude.sign == .plus
            ? "E\(longitude)" : "W\(-longitude)"  // 東経と西経
        return ns + ", " + ew
    }
    func copy() -> Self {   // Selfは実行時のクラス
        return Self(lat:latitude, lon:longitude)
    }
}

class ViewPoint: GPSPoint<Double> {
    let name: String //　プロパティを追加
    required convenience init(lat:Double, lon:Double) {
        self.init(name:"(none)"),lat:lat, lon:lon)
    }
    required init(name:String, lat:Double, lon;Double) {
        self.name = name
        super.init(lat:lat, lon:lon)
    }
    override func copy() -> Self {
        return Self(name:name, lat:latitude, lon:longitude)
    }
    override var description -> String {
        return "ViewPoint: \(name)," + toString()
    }

}
