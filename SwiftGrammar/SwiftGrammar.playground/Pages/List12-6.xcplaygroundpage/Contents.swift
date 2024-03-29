// 通常の関数と同様にクラスなどのメソッド、イニシャライザもクロージャとして扱うことができる
class Friend {
    let name: String
    init(name: String) { self.name = name }
    deinit {
        print("deinit", name)
    }
    func sayName() { print("私は\(name)です。")}
    func sayHello(to f: Friend) {
        print("こんにちは、\(f.name)さん。")
    }

}

// イニシャライザを定数clo1に代入
// (String) -> Friendがクロージャ
let clo1: (String) -> Friend = Friend.init
var clo2: (Friend) -> ()

// doはスコープ機能を使いたいときに利用される。スコープ外になればインスタンスは解放される。
do {
    let fr1 = clo1("烏丸")        // クロージャからインスタンス生成
    clo2 = fr1.sayHello(to:)     // インスタンスのメソッドを代入
    fr1.sayName()                // "私は烏丸です"と表示
}
let fr2 = Friend(name:"久我山")
clo2(fr2)                        // 久我山さん、こんにちは。烏丸です。と表示
clo2 = fr2.sayHello              // "deini 烏丸"と表示
