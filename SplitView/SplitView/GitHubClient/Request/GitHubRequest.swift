//
//  GitHubRequest.swift
//  SplitView
//
//  Created by Swift-Beginners on 2021/03/12.
//

import Foundation

protocol  GitHubRequest {
//    protocolに定義する連想型です
//    protocolの準拠時に、具体的な型を指定します（または型推論で指定されます）
//    ジェネリクスにおけるT的なやつです
//    protocol定義時点では決められず、準拠側で指定したい型があるときが使いどころです。
//    具体的には、APIを叩いて、レスポンスに含まれるJSONから特定の型を作りたい！ってときに使えました。
    
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    <#requirements#>
}
