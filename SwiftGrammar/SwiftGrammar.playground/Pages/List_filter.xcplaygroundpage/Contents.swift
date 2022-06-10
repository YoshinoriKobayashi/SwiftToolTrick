//: [Previous](@previous)

import Foundation

// func filter(_: (T) throws -> Bool) rethrows => [T]
let a = (1...100).filter { $0 % 15 == 0 || $0 % 22 == 0}
print(a)

// func filter(_: (Element) throws -> Bool) rethorws -> [key:sub2]
let b = [""]
