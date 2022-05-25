import Foundation

// 空白を無視して文字列を扱いたいという用途向けに作成した構造体
public struct StringNoBlank {
    public let string: String               // オリジナルの文字列
    public let strWithoutBlank: String?     // 空白抜きの文字列
    public var hasBlank: Bool { strWithoutBlank != nil} // 空白を含むか？

    // 文字列を与えると、空白を取り除いた文字列を作成
    // その文字列と元の文字列を保持
    // 空白が含まれていなかった場合は、元の文字列のみを保持
    public init(_ string: String) {
        // filter：シークエンスを適用して条件に合致する要素だけを取り出す
        let s = String(string.filter{ $0 != " " })  //　空白を取り除いた文字列
        self.string = string
        self.strWithoutBlank = (s.count != string.count) ? s :nil;
    }
    // == は空白のない文字列同士を比較
    // プロトコルEquatableは採用していない
    public static func ==(lhs:StringNoBlank, rhs:StringNoBlank) -> Bool {
        let s1 = lhs.strWithoutBlank ?? lhs.string
        let s2 = rhs.strWithoutBlank ?? rhs.string
        return s1 == s2     // 空白なしの文字列での比較を行う
    }
}

// この拡張定義は、従来のinitを上書きする？
extension StringNoBlank {
    init(_ str: String, substitute: String) {
        string = str
        strWithoutBlank = substitute
    }
}

let a = StringNoBlank("A = B * 10 + X")
let c = StringNoBlank("A = B * 10 + X",substitute:"bbbb")
print(a.hasBlank)       // trueを表示
let b = StringNoBlank("A=B*10+X")
print(b.hasBlank)       // falseを表示
print(a == b)           // trueを表示

// List10-5
// あとで追加、プロトコルに適合していることだけを宣言する
extension StringNoBlank: Equatable {}

// 上記の Equtable を追加すると以下の比較ができるようになる。
let a1 = [StringNoBlank(" N = A(C)"), StringNoBlank("G = N^2")]
let a2 = [StringNoBlank(" N = A ( C )"), StringNoBlank("G=N ^ 2")]
print(a1 == a2)
