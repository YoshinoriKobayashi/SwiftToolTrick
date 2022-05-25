struct SimpleDate {
    var year, month, day:Int

    init() {
        year = 2095; month = 10; day = 31
    } // self.year = 2095 のように書くこともできる
}

protocol Dateable {
    var year: Int{ get }
    var month: Int{ get }
    var day: Int {get }
}

// List2-6 ツェラーの公式
func Zeller(_ y:Int, _ m:Int, _ d:Int) -> Int {
    var y = y, m = m        // 注目！変数y,mは仮引数とは違う
    if m < 3 {              // 1,2月だったら
        m += 12; y -= 1     // 前年の13月、14月として計算する
    }
    let leap = y + y / 4 - y / 100 + y / 400
    return (leap + (13 * m + 8) / 5 + d) % 7
}

// List10-7
extension Dateable {
    var dayOfWeek: Int {
        return Zeller(year, month, day)
    }
}
