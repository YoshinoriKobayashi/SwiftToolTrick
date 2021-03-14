//
//  GitHubAPIError.swift
//  SplitView
//
//  Created by Swift-Beginners on 2021/03/12.
//

import Foundation

// Decodable:
struct GitHubAPIError: Decodable,Error {
    let message: String
    let fieldErros: [FieldError]
    
    struct FieldError: Decodable {
        let resource: String
        let field: String
        let code: String
    }
}
