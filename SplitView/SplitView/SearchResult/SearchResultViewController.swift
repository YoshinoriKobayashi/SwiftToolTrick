//
//  SearchResultViewController.swift
//  SplitView
//
//  Created by Swift-Beginners on 2021/03/12.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var repositories: [Respository] = [] {
        // プロパティ監視、変更後
        didSet {
            // アプリのメインスレッドまたはバックグラウンドスレッドでタスクの実行を連続的または同時に管理するオブジェクト。
            // main:現在のプロセスのメインスレッドに関連付けられているディスパッチキュー。
            // async:作業項目をすぐに実行するようにスケジュールし、すぐに戻ります。

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        
        tableView.register(UITableView.self, forCellReuseIdentifier: "cell")
        
        let request = GitHubAPI.search

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
