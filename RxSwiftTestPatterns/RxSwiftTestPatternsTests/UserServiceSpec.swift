import RxSwift

@testable import RxSwiftTestPatterns
import Quick
import Nimble
import RxBlocking
import Mockingjay

class UserServiceSpec: QuickSpec {
    override func spec() {
        var userService: UserService!
        
        beforeEach {
            userService = UserService()
            
            let userJson = "{\"id\": 1, \"name\": \"test-user\"}"
            //HTTP通信をスタブ化するために、ここではMockingjayというライブラリを使用しています。
            self.stub(uri("https://api.example.com/users/1"), jsonData(userJson.data(using: .utf8)!))
            //ここでは、HTTPリクエストのURLがhttps://api.example.com/users/1だった場合にuserJsonのJSON文字列をレスポンスとして返すという宣言をしています。
            //こうすることで、実際にこのURLにはアクセスせずにすぐにレスポンスが帰ってくるようになります。


        }
        
        it("should fetch an user") {
            let expectedUser = User(id: 1, name: "test-user")
            //UserServiceクラスの検証
            expect(try! userService.fetchUser(by: 1).toBlocking().single()).to(equal(expectedUser))
            //ここでテストしているのは、emitされる要素が1つであることと、その要素の値がexpectedUserと一致していることです。
            //また、Mockingjayによってリクエストの宛先URLがhttps://api.example.com/users/1であることの検証もしていることになります。
        }
    }
}
