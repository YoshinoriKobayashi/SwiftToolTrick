import Foundation

// 2次元の整数行列を表示する

class NumberMatrix {
    let data: [[Int]]               // データ
    let maxval: Int                 // データの最大値

    // 各要素を文字列として表示するために、変数formatに代入したクロージャを利用する
    var format = { (n: Int) -> String in "\(n)" }   // 整形用クロージャ

    // イニシャライザでデータを設定
    init(data:[[Int]]) {
        self.data = data
        // mapでシークエンスの各要素にクロージャを適用
        // maxを組み合わせることで、2次元配列の最大値を求める
        maxval = data.map{ $0.max()! }.max()!
    } // 各行の最大値を求め、それらの最大値を再び求める

    // データの表示
    func output() { // 行列の出力
        for lin in data {
            for col in lin { print(format(col), terminator:"")}
            print(" ")
        }
    }
    // 最大値を100としたパーセント表示にする
    func makePercent() {
        format = { (n:Int) -> String in
            let m = Int(Double(n * 100) / Double(self.maxval) + 0.5)
            // 各要素の印字幅を4文字
            return String("\(m)".suffix(4)) // 空白を踏め

        }

    }
}

// 全体にdo文を入れているのは、実行が終わるときにコードブロック内の変数や定数に格納されていた
// クラス及びクロージャのインスタンスを解放するため
do {
    let mat = NumberMatrix(data:[[200, 10, 0],[1, 990, 1280]])
    mat.output()
}

do {
    let mat = NumberMatrix(data: [[200, 10, 0],[ 1, 990, 1280]])
    mat.makePercent()
    mat.output()

}
