#  SwiftUIでVIOERの例


### View
SwiftUIでは、Viewはビューとロジックの両方を含んでいますが、VIPERフレームワークでは、Viewはビューのみを担当し、ロジックはPresenterに移行されます。Viewは、SwiftUIのViewプロトコルに準拠する必要があります。

### Interactor
Interactorは、ビジネスロジックを担当し、データの取得や加工などのタスクを実行します。SwiftUIでは、InteractorはObservableObjectを採用したクラスとして実装されます。

### Presenter
Presenterは、ViewとInteractorの間で通信を取り持ちます。Viewからの入力をInteractorに送り、Interactorからの応答をViewに戻します。Presenterは、ObservableObjectを採用したクラスとして実装されます。

### Entity
Entityは、アプリケーションで使用されるデータモデルを表します。SwiftUIでは、Entityは普通のSwiftの構造体として実装されます。

### Router
Routerは、VIPERの中心的な役割を担い、画面遷移を制御します。SwiftUIでは、RouterはSwiftUIのNavigationLinkを使用して実装されます。
