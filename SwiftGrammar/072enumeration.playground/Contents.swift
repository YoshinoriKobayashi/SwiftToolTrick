/*
 列挙型（enumeraion）とは、独自の「型」を定義するための機能
 Swiftに用意されていない型を独自に定義する機能
 */

// 列挙体をを使うことで意図しない値が指定されるのを未然に防ぐ

// Week型
enum Week {
    case monday     // 識別子
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

// 変数への代入
var today = Week.monday
// 列挙体名の省略
today = .monday

// aspectRatio() メソッドの引数 contentMode の ContentMode 型（列挙体）
enum ContentMode {
    case fit
    case fill
}
