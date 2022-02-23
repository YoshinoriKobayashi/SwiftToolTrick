import Foundation

// プロトコル
// Swift は、具体的な実装から離れて、型が持つべきメソッドやプロパティなどの
// 宣言をまとめる仕組みを持っており。これをプロトコルという。

// Swiftではクラスではなく、プロトコルを中心にソフトウェア設計、
// プログラミングをすすめることが可能→プロトコル指向

protocol RandomGenerator {
  var randomValue: Int { get }
  func shuffle()
}

// ・プロパティの宣言には var のみが指定でき、 let は指定できない
// ・定数を想定している場合でも var を使う
// ・get や set で当該プロパティが読み込み専用か代入も可能かを指定
// ・定数を想定している場合、 let は使えませんが、 var で { get } と指定することで、
// 「変更できない」という意味合いの指定をすることができる


// プロトコルに適合するクラス
// クラス、構造体、列挙型の名前の後に:を置き、その後に続けてプロトコルを記述することで、
// プロトコルの取り決めにしたがっていることを示す。
// 取り決めに従うことを「適応」あるいは「準拠」(conform）という
class Dice : RandomGenerator {
    var randomValue: Int {
        return _value
    }
    func shuffle() {
        _value = Int(arc4random_uniform(6)) + 1
        
    }
    private var _value: Int = Int(arc4random_uniform(6)) + 1
}

// -------------------------------------
// プロトコルの宣言
protocol Human {
    // プロパティ宣言
    // get,set：読み込み、書き出し可能か
    // ここでは var のみだけで、実装で定数なら let を使うこともある
    // タイププロパティの場合は static を記述
    var name: String? { get }        //　名前
    
    // メソッド宣言：メソッド名、引数、戻り値の型のみ
    // タイプメソッドの場合は static を記述
    func sayHello(to:Human)         // 人に挨拶する。
}
struct Mob : Human {
    let name: String? = nil     // プロパティを定義して実装
    init() {}                   // イニシャライザは何もしない
    func sayHello(to: Human) {
        print("protocol")
    }
    func cheer() {
        print("頑張れ")            // Human には存在しないメソッド
    }
}

// プロトコルは型として使える
// プロトコルHumanを配列として引数に使う。
// 名前の一覧を表示する
func printNames(list:[Human]) {
    for p in list {
        print((p.name ?? "名無し") + "さん")
//        p.cheer()               // 呼び出しはできない
    }
}

// プロトコルの継承
// プロトコルは別のプロトコルを継承して宣言することができる
// プロトコルHumanを継承して、役職などの肩書きプロパティに持つプロトコルStaffを定義する
protocol Staff : Human {
    // 読み書き可能なプロトコル
    var title: String{ get set }
}

// プロトコルの合成
// 複数のプロトコルを指定すると和集合のようになる

// protocol NewProtocol:プロトコル1,プロトコル2 {} 
// var teller: NewProtocol

// 以下も同じ意味
// var teller: プロトコル1 & プロトコル2


// プロトコルの使用例

// プロトコルHumanとStaffの両方で採用されたプロパティとメソッドが利用できる。
// プロトコルStaffを採用
struct Employee: Staff {
    let name: String?            // プロトコルHumanのプロパティ 
    var title:String = ""        // プロトコルStaffのプロパティ
    func sayHello(to p:Human) {  // プロトコルHumanのメソッド
        var s = "ご苦労さまです"
        if let who = p.name { s += "、" + who + "さん"}
        print(s)
    }
}


protocol FullName {
    var lastName: String { get }    // 苗字
    var firstName: String { get }   // 名前 
}

struct Student: Human, FullName {
    let lastName, firstName: String
    var name: String? {                 // 計算型プロパティで実装
        return lastName + firstName     // FullNameのプロパティ
    }
    func sayHello(to p: Human) {          // プロトコルHumanのメソッド
        var s = "こんにちは"
        if let who = p.name { s += "、" + who + "さん"}
        print(s)
    }
}

var a = Mob()
var b = Employee(name:"安岡", title: "ボディガード")
var c = Student(lastName: "夏川", firstName: "真那")
a.sayHello(to: b)   // どうも
b.sayHello(to: c)   // ご苦労様です、夏川真那さん
c.sayHello(to: a)   // こんにちは


// プロトコルと付属型

// プロトコルでは、そのプロトコルを採用する型定義の内部で使われる付属型（ネスト型）に関して宣言することができる。
// associatedtypeというキーワードを使う

protocol SimpleVector {
    associatedtype Element          //　付属型の宣言、ジェネリクス
    var x : Element { get set }
    var y : Element { get set }
}
// 特定の型が指定されていない付属型の宣言は型パラメータとして機能する

struct VectorFloat : SimpleVector {
    typealias Element = Float       // 具体的な型を別名で指定
    var x,y : Float
}
struct VectorDouble : SimpleVector, CustomStringConvertible {
    var x,y: Double         //　具体的な型は推論される
    var description: String { return "[\(x),\(y)]"}
    
    init(x: VectorDouble.Element, y:VectorDouble.Element) {
        self.x = x; self.y = y          // 付属型を型として使うことも可能
    }
    init(vectorFloat d: VectorFloat) {
        self.init(x: Double(d.x), y: Double(d.y))
    }
}

