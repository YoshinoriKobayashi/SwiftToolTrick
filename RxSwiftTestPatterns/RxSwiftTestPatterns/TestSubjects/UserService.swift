import Alamofire
import RxSwift

struct User: Decodable, Equatable {
    let id: Int
    let name: String
}

//APIクライアント
//HTTP通信を行うAPIクライアントクラスのメソッドの戻り値の型はSingleを使うことが多いですが、これはBlockingパターンを使用できる典型的な例です。
//自分は使ったことがないですが、CompletableやMaybeを返す関数もBlockingパターンが使えます。

//これらのObservableは必ずcompletedかerrorイベントをemitします。
//なのでRxBlockingによってこれらのイベントがemitされるまでブロックし、最後に結果を検証する事ができます。
class UserService {
    func fetchUser(by userId: Int) -> Single<User> {
        return Single.create { single in
            AF.request("https://api.example.com/users/\(userId)").responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        single(.success(user))
                    } catch {
                        single(.failure(error))
                    }
                case let .failure(error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
