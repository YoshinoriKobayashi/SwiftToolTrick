//: [Previous](@previous)

import Foundation

// List13-15
// 型パラメータを持つクラスを定義し、さらにそのクラスを継承して別のクラスを定義することができます。

// 型パラメータで指定した型のプロパティを持つクラスGeoPointを定義
// 地図上の地点を緯度経度で表すことを意図
// 要素の型は指定していない
class GeoPoint<Element> {
    var latitude, longitude: Element           // 緯度、軽度
    required init(lat:Element, lon:Element) {  // 必須イニシャライザ
        self.latitude = lat;  self.longitude = lon
    }
    func toString() -> String { return "\(latitude), \(longitude)"}
}

// GeoPointを継承するサブクラス、型パラメータに制約をつけて、
// プロトコルFloatingPointに適合する型（実数）のみが使用できるようにする
// スーパークラスの関数toString()を利用して、プロコトルCustomStringConvertibleも実装する
class GPSPoint<T:FloatingPoint> : GeoPoint<T>, CustomStringConvertible {
    var description: String{ return "GPSPoint: " + toString()}


    override func toString() -> String {    // 実数に適用可能な定義
        // latitudeが正で有ることを調べる
        // sign：浮動小数点値の符号を指定
        let ns = latitude.sign == .plus     // latitude >= 0.0 はエラー
            ? "N\(latitude)" : "S\(-latitude)"  // 北緯と南緯
        let ew = longitude.sign == .plus
            ? "E\(longitude)" : "W\(-longitude)"  // 東経と西経
        return ns + ", " + ew
    }
    // インスタンスの複製を作れる
    func copy() -> Self {   // Selfは実行時のクラス、そのクラスのイニシャライザを使う
        return Self(lat:latitude, lon:longitude)
    }
}

// GPSPointのサブクラスを定義
// 型パラメータをDouble型に限定、クラスViewPointはジェネリック型ではない
class ViewPoint: GPSPoint<Double> {
    let name: String //　地点の名称を示す文字列を追加
    required convenience init(lat: Double, lon: Double) {   // 必須
        self.init(lat: lat, lon: lon)
    }
    required init(name:String, lat: Double, lon: Double) {
        self.name = name
        super.init(lat: lat, lon: lon)
    }
    // インスタンスの複製を作れる
    override func copy() -> Self {  // Selfは実行時のクラス
        return Self(name: name, lat:latitude, lon:longitude)
    }
    override var description: String {
        return "ViewPoint:\(name)," + toString()
    }
}

var g1 = GPSPoint<Float>(lat: 35.70040, lon: 139.77217)
print(g1)   // GPSPoint 35.7004、139.772を表示
var g2 = ViewPoint(name: "松本城", lat: 36.238064, lon: 137.968457)
var g3 = g2.copy()
print(g3)  // ViewPoint: 松本城、N36.238064、E137.968457
print(g2 === g3) // false を表示（違ういオブジェクトであることがわる）

// 型パラメータをもつtypealias
//typealias Array<T,U> = ([T],[U])
//let wicca: Array<Int,String> = ([1107,5210],["塔","工房"])

//typealias SortableArray<T:Comparable> = Array<T>
//let ta: SortableArray = [0.138, 1.09, 0.0, -1.1304]
//let sa: SortableArray = ["palm","top","tiger"]



