//
//  GitHubClientError.swift
//  SplitView
//
//  Created by Swift-Beginners on 2021/03/12.
//

import Foundation

enum GitHubClientError: Error {
    // 通信に失敗
    case connectionError(Error)
    // レスポンスの解釈に失敗
    case responseParseError(Error)
    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
}
