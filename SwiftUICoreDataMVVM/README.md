#  SwiftUIでCoreDataをMVVMで活用するためのサンプル


このサンプルは次の動画を参考にしている。
[Core Data MVVM in SwiftUI App Using NSFetchedResultsController](https://youtu.be/gGM_Qn3CUfQ)


## 注意点
### CoreDataのAttributeでOptionalのチェックは外している。
オプションの属性は、永続ストアに保存する際に値を持つ必要はありません。属性はデフォルトでオプションです。
CoreDataのオプショナルは、Swiftのオプショナルと同じではありません。たとえば、オブジェクトの初期化から最初の保存までの間に値を柔軟に設定する必要がある場合、必須属性を表すために Swift のオプショナルを使うことができます。
https://developer.apple.com/documentation/coredata/modeling_data/configuring_attributes

