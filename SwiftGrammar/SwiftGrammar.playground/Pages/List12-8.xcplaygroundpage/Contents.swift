// 12-8
// クロージャを引数とする関数の定義

import Darwin
let list = ["fig.gif","filelist1.swift","OLD","sample.swift"]

func separate(_ list:[String],by filter:(String)->Bool)
    -> ([String],[String]) {    // 配列のタプルを返す

        var sel = [String]()    // 条件に合致する要素を格納する配列
        var des = [String]()    // 条件に合致しない要素を格納する配列
        for s in list {         // 配列要素を1つずつ取り出す
            if filter(s) {      // クロージャを使って条件判定
                sel.append(s)
            } else {
                des.append(s)
            }
        }
        return (sel, des)       // タプルを作って返す
}

let t = separate(list, by : {
    for ch in $0 {  // $0に配列listの1つの要素が入る
        print("ch:\(ch)")
        // switch case の省略形
        if case "A" ... "Z" = ch { return true  }
    }
    return false
})

print(t)

// トレイリングクロージャ
let t2 = separate(list) {
    for ch in $0 {
        if case "A" ... "Z" = ch { return true }
    }
    return false
}
