//
//  RecipeListViewController.swift
//  FoodApp
//
//  Created by Dmitriy Petrov on 20/11/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class RecipeListViewController: DisposableViewController {
    
    // アニメーションテーブルの場合は、AnimatableSectionModel<Section, ItemType> を使用する必要があります
    typealias RecipeListSectionModel = AnimatableSectionModel<String, Recipe>
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>!
    var viewModel: RecipeListViewModel!
    
    private var editBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My recipes"
        
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        registerCell()
        setupDataSource()
    }
    
    
    private func registerCell() {
        tableView.register(cellType: RecipeListTableViewCell.self)
    }
    
    private func setupDataSource() {
        // RxTableViewSectionedAnimatedDataSource
        // AnimationConfiguration：様々なアクティビティにアニメーションの種類を設定する
        // ConfigureCell：セルを返し、それをviewModelにバインドする。ここで、いくつかのアクティビティをセル要素にバインドすることができます。例えば、ボタンのアクティビティなどです。
        dataSource = RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .right,
                                                           reloadAnimation: .none,
                                                           deleteAnimation: .left),
            configureCell: configureCell,
            canEditRowAtIndexPath: canEditRowAtIndexPath,
            canMoveRowAtIndexPath: canMoveRowAtIndexPath
        )
    }
    
    private func setupNavigationBar() {
        editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [editBarButton]
    }
}

extension RecipeListViewController: BindableType {
    func bindViewModel() {
        bindDataSource()
        bindDeleted()
        bindMoved()
        bindSelected()
        bindNavigationBar()
    }
    
    private func bindDataSource() {
        // DataSourceをSectionModelにバインドし、Driverを使用します。
        viewModel.dataSource.asDriver()
            .map { [RecipeListSectionModel(model: "", items: $0)] }
            // drive
            // カスタムバインダー関数を使用して、観測可能なシーケンスを購読します。
            // このメソッドは `MainThread` からのみ呼び出すことができます。
            // items
            // 変換を実行するために使用されるカスタムリアクティブデータを使用して、
            // 要素のシーケンスをテーブルビューの行にバインドします。
            // このメソッドは、サブスクリプションが破棄されない限り、
            // データソースを保持します(結果 `Disposable`) が廃棄された場合)。 source`
            // の観測可能なシーケンスが正常に終了した場合、データソースは最新の要素を提示する。
            // サブスクリプションが破棄されない限り
            .debug("asDriver")
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindDeleted() {
        // Delegate` メッセージ `tableView:commitEditingStyle:forRowAtIndexPath:` のリアクティブラッパーです。
        tableView.rx.itemDeleted.asDriver()
            .debug("itemDeleted")
            //  要素ハンドラ、完了ハンドラ、破棄ハンドラを観測可能なシーケンスにサブスクライブします。
            //  このメソッドは `MainThread` からのみ呼び出すことができる。
            // ドライバ`はエラーにならないので、エラーコールバックは公開されない。
            .drive(onNext: { [unowned self] indexPath in
                self.viewModel.dataSource.remove(at: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindMoved() {
        // Delegate` メッセージ `tableView:moveRowAtIndexPath:toIndexPath:` に対するリアクティブラッパーです。
        tableView.rx.itemMoved.asDriver()
            .debug("itemMoved")
            .drive(onNext: { [unowned self] source, destination in
                guard source != destination else { return }
                // value：行動主体の現在値
                let item = self.viewModel.dataSource.value[source.row]
                self.viewModel.dataSource.replaceElement(at: source.row, insertTo: destination.row, with: item)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSelected() {
        tableView.rx.modelSelected(Recipe.self)
            .asDriver()
            .debug("modelSelected")
            .drive(onNext: { [unowned self] recipe in
                var vc = RecipeViewController.initFromNib()
                vc.bind(to: RecipeViewModel(withRecipe: recipe))
                
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindNavigationBar() {
        editBarButton.rx.tap.asDriver()
            .debug("tap")
            .map { [unowned self] in self.tableView.isEditing }
            .drive(onNext: { [unowned self] result in self.tableView.setEditing(!result, animated: true) })
            .disposed(by: disposeBag)
    }
}

// MARK: Data Source Configuration

extension RecipeListViewController {
    private var configureCell: RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>.ConfigureCell {
        return { _, tableView, indexPath, recipe in
            var cell: RecipeListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.bind(to: RecipeListCellViewModel(withRecipe: recipe))
            return cell
        }
    }
    
    private var canEditRowAtIndexPath: RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>.CanEditRowAtIndexPath {
        return { [unowned self] _, _ in
            if self.tableView.isEditing {
                return true
            } else {
                return false
            }
        }
    }
    
    private var canMoveRowAtIndexPath: RxTableViewSectionedAnimatedDataSource<RecipeListSectionModel>.CanMoveRowAtIndexPath {
        return { _, _ in
            return true
        }
    }
}
