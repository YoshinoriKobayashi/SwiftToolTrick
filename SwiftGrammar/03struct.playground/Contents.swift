// 構造体
/*
 ・値型のデータ
 ・代入や関数呼び出しでデータの実態がコピーされ新しいインスタンスが作成される
 ・複数箇所から同じ実体を参照するときはクラスを使う
 */

// 構造体内の変数をプロパティと呼ぶ
// メンバはメソッド、プロパティを含めた総称
struct SimpleDate {
    var year: Int   // 年
    var month: Int  // 月
    var day: Int    // 日
}

// 既定イニシャライザ　宣言時に設定
struct SimpleDate2 {
    var year:Int = 2010
    var month:Int = 7
    var day = 28
}
var d = SimpleDate2()
print(d.year)
d.day = 29 // 代入も可能

/* ---------------------------
        全項目イニシャライザ 
-----------------------------*/
// 個々のプロパティの値を指定してインスタンスを生成するイニシャライザ
// 各プロパティ名を引数のキーワードとして書き連ねる

// 構造体で初期値を指定していない場合は、使うときに指定を強制する
struct AnotherDate {
    var month,day:Int
    var year = 1998
}
var move = AnotherDate(month: 5, day: 6, year: 1998) // 初期値を指定しないとエラーになる
var camp = AnotherDate(month: 8, day: 8) // year は初期値が設定されているので省略できる。

// 構造体は定数に代入したら変更できない
let event = SimpleDate(year: 2000, month: 9, day: 1998)
// event.year = 10 これはエラー、構造体が値型のため。クラスはできる参照型のため

// 定数プロパティ
// 定数はあとから値が変更できないので、初期化を強制
struct Time {
    let in24h: Bool = false  // 24時制 or 12時制
    var hour = 0,min = 0
}
var t1 = Time()
// var t2 = Time(in24h:true,hour:7,min:0) エラーになる。定数は変更できない
var t2 = Time(hour: 7, min: 0) 

/* まとめ
 ・引数キーワードは、プロパティが定義されている順に強制される
 ・初期値がないプロパティは、イニシャライザで必ず指定
 ・初期値があるプロパティは、イニシャライザで指定しなくていい
 ・初期値がある定数プロパティは、イニシャライザで指定できない
 */

/* ---------------------------
    カスタムイニシャライザ
-----------------------------*/
struct SimpleDate3 {
    var year,month,day:Int
    // init キーワードを指定して初期化する
    init() {
        self.year = 2095  // self も使えるが、省略できる
        month = 10;day = 31
    }
}
var m = SimpleDate3()   // 生成時にカスタムイニシャライザ init が動く
print(m.year)

/*--------------------------------------------------
メソッド
 ---------------------------------------------------*/

// ▼メソッド定義を持つ構造体Time型
struct Time2 {                // 時間と分のみを持つTime型
    let hour, min : Int      // 定数で時刻を保持。全項目イニシャライザを使う
    func advanced(min:Int) -> Time {        //　分を加算
        var m = self.min + min
        var h = self.hour
        if m >= 60 {
            h = (h + m / 60) % 24
            m %= 60
        }
        return Time(hour:h,min:m)   // 新しいインスタンスを返す
    }
    func toString() -> String {     // 時刻を文字列として返す
        let h = hour < 10 ? "\(hour)":"\(hour)"
        let m = min < 10 ? "0\(min)":"\(min)"
        return h + ":" + m
    }
}
let t11 = Time2(hour:22,min:45)       // 全項目イニシャライザ
let t21 = t11.advanced(min:140)       // メソッド

// 構造体の内容を変更するメソッド
// 原則、インスタンスは変更できない
// mutatingをつけるとインスタンスの変更ができるメソッドになる
//
//struct Clock {                          // 時間と分のみを持つ Clock 型
//    var hour = 0, min = 0               // 全項目イニシャライザを使う
//    mutating func advance(min:Int) {    // プロパティの値を変更する
//        let m = self.min + min
//        if m >= 60 {
//            self.min = m % 60           // ←こここで変更
//            let t = self.hour + m / 60
//            self.hour = t % 24          // ←こここで変更
//        } else {
//            self.min = m
//        }
//    }
//    mutating func inc(){                // このメソッドも mutating
//        self.advance(min: 1)            // 1分すすめる
//    }
//    func toString() -> String {
//        let h = hour < 10 ? "\(hour)":"\(hour)"
//        let m = min < 10 ? "0\(min)":"\(min)"
//        return h + ":" + m        
//    }
//}
//var tic = Clock(hour:19,min:48)         // 全項目イニシャライザ
//tic.advance(min: 19)                    // 19:59
//tic.inc()
//print(tic.toString))                    // 20:00 を出力

// タイプメソッド
// クラスメソッドに相当するもの
// タイプメソッドは、全インスタンスから共通利用されるもの、インスタンスの作り方、その型を使う上で便利な機能
struct SimpleDate {
    var year, month, day: Int
    static func isLeap(_ y: Int) -> Bool {      // タイプメソッド
        return (y % 4 == 0) && (y % 100 != 0 || y % 400 == 0)
    }
    static func daysOfMonth(_ m:Int, year:Int) -> Int {
        switch m {
        case 2: return isLeap(year) ? 29 : 28       // Self.isLeap でも同じ
        case 4, 6, 11:  return 30
        default: return 31
        }
    }
    func leapYear() ->Bool {
        SimpleDate.isLeap(year)                     // 型名またはSelfが必要
    }
}

SimpleDate.isLeap(2000)                 // trueが返る
SimpleDate.dayOfMonth(2, year:2000)     // 29が返る
let d= SimpleDate(year:2024, month: 11, day: 7)
print("うるう年？", d.leapYear())        // true が返る

//----------------------------------------------------------
//プロパティ
//・格納型プロパティ・・・定数や変数が機能を提供するプロパティ
//・計算型プロパティ・・・値の参照と更新の機能を手続きで構成するプロパティ
//・タイププロパティ・・・型の定義は名前空間を構成しますが、この名前空間にはインスタンの定義、タイプメソッドの定義だけでなく、その型に関連した情報を表すプロパティを定義できます。

// タイププロパティ
struct DateWithString {
    let string: String
    let yaer, month, day: Int
    static let mons = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]     // タイププロパティ。配列リテラル
    static var longFormat = false               // タイププロパティ
    init(_ y:Int, _ m:int, _ d:Int) {
        year = y; month = m; day = d
        string = DateWithString.longFormat          // タイププロパティを参照
            ? DateWithString.longString(y, m, d)    // タイプメソッドを参照
            : DateWithString.shortString(y, m, d)    // 型名またはSelfで修飾
    }
    static func twoDigits(_ n:Int) -> String {
        let i = n % 100
        return i < 10 ? "0\(i)" : "\(i)"
    }
    static func longString(_ y:Int, _ m:Int,_ d:Int) -> String {
        return "\(y)-" + twoDigits(m)   + "-" + twoDigits(d)
    }
    static func shortString(_ y:Int, _ m:Int,_ d:Int) -> String {
        return twoDigits(d) + mons[m-1] + twoDigits(y)
    }
    
} 
let a = DateWithString(2025,1,20)       // longFormat = false
print(a.string)                         // "20Jan25" を出力
DateWithString.longFormat = true
print(b.string)                         // "2025-01-21" を出力


// 計算型プロパティ
// 値の参照と更新の機能を手続きで構成するプロパティで、アクセスする側からは格納型プロパティと区別なく利用できる。
// 参照した結果の値を計算するのが get ゲッター
// 指定された値を使ってプロパティを更新するのが set　セッター

// 省略記法
// ・setは仮引数を省略した場合は、 newValue という名前の引数があるものとして利用できる
// ・getがreturnだけの場合、関数定義と同様、returnを省略して式だけを記述できる
// ・setは省略可能
// ・getだけのときは、キーワードgetとgetを囲む{}を省略できる

struct Ounce {
    var mL:Double = 0.0             // 値はミリリットルで保持。初期値は必須
    static let ounceUS = 29.5735    // 1オンス（米国）
    init(ounce:Double) {
        self.ounce = ounce          // 計算型プロパティを使って値を設定
    }
    var ounce: Double {             //　計算型プロパティ
        get { ml / Ounce.ounceUS }
        set { ml = newValue * Ounce.ounceUS }      // newValue は仮引数
    }
}
var a = Ounce(ounce: 2.0)       // 2.0オンスで初期化
print(a.mL)
a.ounce += 8.0
print(a.ounce)

