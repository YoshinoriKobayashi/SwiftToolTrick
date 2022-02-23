// 関数


/*

func 関数名( 仮引数: 型 ) -> 型　{
   文・・・
}

 ・関数名、仮引数も最初小文字のキャメルケース
 ・値を返さない関数は「->」を省略。あるいは「-> ()、-> Void」と書く
 ・値を返す場合は、{}（コードブロック）の中に必ず return が必要
 
 */

var total = 0

// 整数の引数を1つとり、整数を返す
func count(n: Int) -> Int {
    total += n
    return total
}
// 引数も返り値もない
func reset() { total = 0 }
reset()
let ax = 10
let bx = count(n: ax - 5)     // 仮引数:実引数
print("\(count(n: ax))")     // 関数の返り値として15を表示

/*
 return の省略
 
 関数本体が return だけの場合は、return を省略できる。
*/
func messageA() -> String {
    return "現在の値は\(total)です。"
}
func messageB() -> String { "現在の値は\(total)です。"}

/* ----------------------------
 引数ラベル（argument label）
*/

func buy(product:Int, price: Int, quantity:Int) {
    print("Product:\(product), amout = \(price * quantity)")
}
buy(product: 19090,price: 18000, quantity: 1)

// Swift では同じ名前の関数を複数定義することが可能。
// 異なる引数を持つ関数はそれぞれ別のものとして扱う
// なのでラベルがないと、関数を用途がよくわからない。

// 仮引数と引数ラベル
// 呼び出しと関数内で使う変数をわけたい。
func area (height h:Double,width w:Double) -> Double {
    // 引数ラベル　仮引数名:データ型
    // h , w は仮引数、関数内で使う変数にもなっている。シンプルに使える
    return h * w
}
// 呼び出すときは、引数ラベルを使う。
let a = area(height: 10.0, width: 12.5) 

// 仮引数の省略
// _ で省略できる。
// Swift _ はワイルドカード、省略の意味

// inout 引数
// Swift は値渡しだが、inout だと参照渡しになる
func mySwap(_ a: inout Int, _ b: inout Int) {
    let  t = a; a = b; b = t
}
var x = 100
var y = 0
// 実引数として & を使う
mySwap(&x, &y)

// 既定値
let fontSize: Float = 12.0
// 既定値はグローバル変数でもいい
// 既定値と同時に inout は指定できない
func setFont(name:String, size:Float = fontSize, bold:Bool = false) {
    print("\(name)\(size)" + (bold ? " [B]" : ""))
}
func setGray(level:Int = 255,_ alpha:Float = 1.0){
    print("Gray=\(level),Alpha=\(alpha)")
}
setFont(name: "RanglanPunch")
setFont(name: "RanglanPunch",bold: true)

// Swift での特別なルール
// ・引数の値は関数内で変更できない
// ・関数内で仮引数と同名の変数を定義できる
func dayOfweek(_ y:Int, _ m:Int, _ d:Int) -> Int {
    var y = y, m = m
    if m < 3 {
        m += 12; y -= 1
    }
    let leep = y + y / 4 - y / 100 + y / 400
    return (leep + (13 * m + 8) / 5 + d ) % 7
    
}

// 返り値を使わない
// _ で捨てるか、属性値を指定する
@discardableResult
func sayHello(to n:String) -> Bool { return true }

// ネスト関数のルール
//　・関数の外部からネスト関数にアクセスできない
//  ・ネスト関数で使う、親関数の変数、定義には前方参照がある
// ・クロージャの性質をもつ
func printMonth(first fday:Int, days:Int) {
    var d = 1 - fday
    func daystr() -> String {
        if d <= 0 {
            return "   "
        } else {
            return (d < 10 ? "  \(d)" : " \(d)")
        }
    }
    while d <= days {
        var line = ""
        for _ in 0 ..< 7 {
            line += daystr()
            d += 1
            if d > days { break }
        }
        print(line)
    }
}

// オーバーロード
// 引数の個数が違う関数を定義することができる。
func mySwap(_ a: inout Int, _ b: inout Int, _ c: inout Int) {
    let  t = a; a = b; c = t
}
var s = 10,t = 20
var x2 = 1, y2 = 2, z2 = 3
mySwap(&s, &t)
print ("s=\(s), t=\(t)")
mySwap(&x2, &y2, &z2)
print ("x=\(x2), y=\(y2), z=\(z2)")
// 特に指定しなくても、同じ関数があればオーバーライドされる。両方の関数つかえる
// 見え目は引数が違う同じ関数が使えるようにみえる

// 引数ラベルを使ったオーバーロード
// 引数ラベルが異なると別の関数で呼び出せる。
// 構造体やクラスのイニシャライザをオーバーロードするときに役立つ
func mySwap(little a: inout Int, great b: inout Int) {
    if a > b {
        let t = a; a = b; b = t 
    }
}
var s2 = 10, t2 = 20
mySwap(little: &s2, great: &t2)
print("s=\(s), t=\(t)")

// 関数の書き方、引数ラベルを含めてかく
// mySwap(little:great:)
// mySwap(_:_:_:)

// タプル

