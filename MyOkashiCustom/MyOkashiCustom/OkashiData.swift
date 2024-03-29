//
//  OkashiData.swift
//  MyOkashiCustom
//
//  Created by Swift-Beginners on 2021/06/05.
//

import Foundation
import UIKit

// Identifiableプロトコルを利用して、お菓子の情報をまとめる構造体
// Identifiable を指定すると、データを一意に特定するために「id」と呼ばれるプロパティを定義する必要があります。
struct OkashiItem: Identifiable {
    let id = UUID()
    let name: String
    let link: URL
    let image: UIImage
}

// お菓子データ検索用クラス
// ObservableObject 内部でプロトコルジェネリクスが使われている
class OkashiData: ObservableObject {
    // JSONのデータ構造
    struct ResultJson: Codable {
        // JsonのItem内のデータ構造
        struct Item: Codable {
            // お菓子の名称
            let name:String?
            // 掲載URL
            let url: URL?
            // 画像URL
            let image:URL?
        }
        // 複数要素
        let item: [Item]?
    }

    // お菓子のリスト（Identifiableプロトコル）
    // 配列 [データ型] = []
    // @Published を付与することで、プロパティを監視して自動通知
    // ObservableObjectプロトコルに準拠した内部のプロパティに、@Publishedを付与することで、プロパティを監視して状態の変化をサブスクライバーに自動通知をしてViewを再描画することができます。
    // ObservableObjectプロトコルに準拠すると、プロパティへの変更を自動的に通知するための、@Publisheを使用できるようになります
    @Published var okashiList: [OkashiItem] = []

    // Web API検索用メソッド　第一引数:keyword検索したいワード
    func searchOkashi(keyword: String) {
        // デバックエリアに出力
        print(keyword)
        // お菓子の検索キーワードをURLエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        // リクエストURLの組み立て
        guard let req_url = URL(string:"https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        print(req_url)

        // リクエストに必要な情報を生成
        // URL文字列からリクエストのオブジェクト作成
        let req = URLRequest(url: req_url)
        // データ転送を管理するためのセッション生成
        let session = URLSession(configuration: .default, delegate: nil,delegateQueue: OperationQueue.main)
        // リクエストをタスクとして登録
        let task = session.dataTask(with: req,completionHandler: {
            (data,response,error) in
            // セッション終了
            session.finishTasksAndInvalidate()
            // do try catch エラーハンドリング
            do {
                // JSONDecoderのインスタンス取得
                let decoder = JSONDecoder()
                // 受け取ったJSONベースをパース（解析）して格納
                let json = try decoder.decode(ResultJson.self, from: data!)

                // お菓子の情報が取得できているか確認
                if let items = json.item {
                    // お菓子のリストを初期化
                    self.okashiList.removeAll()
                    // 取得しているお菓子の数だけ処理
                    for item in items {
                        // お菓子の名称、掲載URL、画像URLのアンラップ
                        if let name = item.name,
                           let link = item.url,
                           let imageUrl = item.image,
                           let imageData = try? Data(contentsOf: imageUrl),
                           let image = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal) {

                            // 1つのお菓子の構造体でまとめて管理
                            let okashi = OkashiItem(name: name, link: link, image: image)
                            // お菓子の配列へ追加
                            self.okashiList.append(okashi)
                        }
                    }
                    print(self.okashiList)

                }
            } catch {
                // エラー処理
                print("エラーが出ました")
                
            }
        })
        // ダンロード開始
        task.resume()
    }
}
