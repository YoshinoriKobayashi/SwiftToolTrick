//
//  ViewController.swift
//  RxDataSources_template
//
//  Created by kobayashi on 2022/02/28.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

/// TableViewCellに紐付けるDataModel
struct CustomCellModel {
    var name: String
    var email: String
}

/// セクションヘッダーの名前とセクション内のitem
struct SectionOfCustomData {
    /// セクションヘッダーの名前
    var header: String
    /// indexPath.row のcellデータ
    var items: [Item]
}

/// RxDataSourceを使ってDataModelとdataSourceを紐付けるため
extension SectionOfCustomData: SectionModelType {
    // ItemにCellのDataModelに紐付ける
    typealias Item = CustomCellModel
    
    // ほぼテンプレで可能
    init(original: SectionOfCustomData,items: [Item]) {
        self = original
        self.items = items
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(
        configureCell: { dataSource, tableView, IndexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath)
            cell.textLabel?.text = item
        }
    )


}

