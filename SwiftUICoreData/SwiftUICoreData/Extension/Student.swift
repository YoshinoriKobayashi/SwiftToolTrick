//
//  Student.swift
//  SwiftUICoreData
//
//  Created by yoshiiikoba on 2021/09/17.
//

import Foundation

// Core Data 対象属性がnilだった場合のデフォルト値定義を１箇所に集め、残りのコードではオプション性を気にする必要がなくなります。

extension Student {
    /// 値がnilの場合のデフォルト値定義
    public var wrappedBirthday: Date { birthday ?? Date() }
    public var wrappedClub: String { club ?? "" }
    public var wrappedName: String { name ?? "" }
    public var wrappedNameOfClass: String { nameOfClass ?? "" }
    public var wrappedSid: String { sid ?? "" }
}
