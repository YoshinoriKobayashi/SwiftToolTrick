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
/// まず、SectionModelTypeプロトコルに準拠した構造体でセクションを定義することから始めましょう。
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
        
    let disposeBag = DisposeBag()
    
    // dataSourceオブジェクトを作成し、SectionOfCustomData型を渡します。
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(
        configureCell: { dataSource, tableView, IndexPath, item in
            print("=== RxTableViewSectionedReloadDataSource")
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath)
            cell.textLabel?.text = item.name
            return cell
        })
    
    // 複数のsectionを表示させたい場合は、SectionOfCustomDataを生成していきます。
    // SectionOfCustomData
    let sections = [SectionOfCustomData(header: "1st section",
                                        items: [CustomCellModel(name: "山田花子", email: "hanako@gmail.com"),
                                                CustomCellModel(name: "田中太郎", email: "taro@gmail.com"),
                                                CustomCellModel(name: "石田真一", email: "shinichi@gmail.com")]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 実際のデータをCustomDataオブジェクトのObservableシーケンスとして定義し、それをtableViewにバインドします。
        Observable.just(sections) // sectionを生成して
            .debug("just")
            .bind(to: tableView.rx.items(dataSource: dataSource)) // itemのdataSourceい紐付ける
            .disposed(by: disposeBag)
    }

}

