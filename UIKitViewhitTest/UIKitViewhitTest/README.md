#  Viewの重なりの実験、hitTest(:with:)の動作を確認

hitTest(:with:)は内部でpoint(inside:with:)を呼び出し、ビューがタッチ位置に含まれているかどうかを確認します。
含まれていると判定(true)されたら、サブビューのhitTest(:with:)を呼び、これを再帰的に繰り返していきます。
ビュー階層の一番深い位置でtrueと判定されたビューが、タッチされたビューであると判断されます。

### 参考
[[iOS] hitTest(:with:)を具体例で解説する](https://qiita.com/takehilo/items/ff90c23ec83809539c3c)

