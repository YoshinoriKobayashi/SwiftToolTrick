# CoreDateをSwiftUIのプレビューで使う方法


このXcodeプロジェクトは、Xcodeプレビューでビューを操作するためのサポートなしで、基本的なCore Dataモデルを使用しています。

このプロジェクトはXcode 12.5.1を使用して作成されました。必要であれば、そのバージョンのXcodeをダウンロードし、フォローしてください。

Xcode Previewsを駆動するために必要なコードを含む完成したプロジェクトは、この記事の最後に含まれています。

このプロジェクトでは、「Practical Core Data」の第1章で提供されている指示にほぼ従って私が作成したアプリを見ることができます。

このアプリは非常に基本的なもので、ユーザーがムービーのリストにムービーを追加し、詳細ビューに移動し、そのムービーの名前を編集することができます。

<img src="https://www.russellgordon.ca/tutorials/core-data-and-xcode-previews/app-screenshots-light.png">


このアプリとStorageProviderクラスがどのように動作するかについては、ここでは詳しく説明しませんが、アプリのデータ層をビュー層から分離する方法については、かなり公平な例だと思います。提供されたコメントが明確であることを望みます。

アプリ内のビューを調べると、Xcode Previewsのコードがコメントアウトされていることがわかります。

3つのステップのうち、最初のステップを完了することで、その修正に着手しましょう。


##　参考サイト
- [Core Data and Xcode Previews](https://www.russellgordon.ca/tutorials/core-data-and-xcode-previews/)




