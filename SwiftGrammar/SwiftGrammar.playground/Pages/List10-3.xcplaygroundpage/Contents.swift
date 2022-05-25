// 拡張定義とプロトコルへの適合

struct Ounce: ExpressibleByFloatLiteral{
    var mL:Double = 0.0             // 値はミリリットルで保持。初期値は必須。
    static let ounceUS = 29.5735    // 1オンス（米国）
    init(ounce: Double) {
        self.ounce = ounce          // 計算型プロパティを使って値を設定
    }
    init(floatLiteral value: Double) {
        self.init(ounce: value)
    }
    var ounce: Double {             // 計算型プロパティの定義
        get { mL / Ounce.ounceUS }
        set { mL = newValue * Ounce.ounceUS }
    }
}

protocol ExpressibleByFloatLiteral {
    associatedtype FloatLiteralType // 付属型（ジェネリクス）
    init(floatLiteral value: FloatLiteralType)
}


var a = Ounce(ounce: 2.0)   // 2.0オンスで初期化
print(a.mL)                 // 59.147を出力
a.ounce += 8.0              // 8.0オンスを追加
print(a.ounce)              // 10.0を出力

var b = Ounce(floatLiteral: 2.0)
print(b.mL)                 // 
