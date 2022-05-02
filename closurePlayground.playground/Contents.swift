import UIKit

var greeting = "Hello, playground"

let names = ["Chris","Alex","Ewa","Barry","Daniella"]

//func backward(_ s1: String, _ s2: String) -> Bool {
//    return s1 > s2
//}
//var reversedNames = names.sorted(by: backward)

//let reversedNames = names.sorted(by:  { (s1: String, s2: String) -> Bool in return s1 > s2})

// コンテキストからの型の推論
//let reversedNames = names.sorted(by: { s1,s2 in return s1 > s2})

// 単一式クロージャによる暗黙の戻り値
let recersedNames = names.sorted(by: {s1,s2 in s1 > s2})
