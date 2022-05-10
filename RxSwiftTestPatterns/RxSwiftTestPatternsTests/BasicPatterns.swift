import RxSwift

@testable import RxSwiftTestPatterns
import Quick
import Nimble
import RxTest
import RxBlocking


/*
 RxSwiftを利用していると、入力や戻り値の型にObservable型をとる関数が出てきます。
 通常の関数のテストであれば、何か入力を与えて関数を実行し、その結果を検証するということができますが、戻り値の型がObservable型である関数は通常の関数のようにテストすることは出来ません。
 こうしたRxSwift特有のコードをテストするための便利な機能を提供してくれるのが、RxTestおよびRxBlockingです。

 ◆RxTest
 RxTestが提供するTestSchedulerは、指定した時刻にObservableにイベントを発行することができるスケジューラです。
 TestSchedulerを利用することで、どの時刻にどんなイベントがオブザーバに届いたのかを検証することができるようになります。

 また、RxTestを使う上でおさえておきたいものとして、HotObservableとColdObservableがあります。

 HotObservableは、オブザーバがいるいないにかかわらず、指定された時刻に正確にイベントを発行するObservableです。
 つまり、オブザーバがサブスクライブするタイミングによってはイベントが受け取れない可能性があるということです。

 ColdObservableは、新しくオブザーバがサブスクライブすると、イベントを最初からリプレイします。
 こちらはHotObservableとは違い、オブザーバはサブスクライブするタイミングに関わらず最初のイベントから受け取ることが出来ます。

 */

/*
 ◆RxBlocking
 RxBlockingは、通常のObservableをBlockingObservableに変換します。
 BlockingObservableはcompletedイベントが発行されるかタイムアウトするまで、カレントスレッドをブロックします。
 これにより、イベントが非同期に発行される場合でも簡単にテストをすることができます。
 */

class BasicPatterns: QuickSpec {
    override func spec() {
        var scheduler: TestScheduler!
        let disposeBag = DisposeBag()
    
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
        }
        
        it("HotObservable + start") {
            //scheduler.createHotObservable()メソッドは、HotObservableを生成します。
            //ここでは、110、210、310という時刻にnextイベントを発行するよう指定しています。
            //10、20、30というのは、nextイベントとともにオブザーバに通知される要素(Element)です。
            let xs = scheduler.createHotObservable([
                Recorded.next(110, 10),
                Recorded.next(210, 20),
                Recorded.next(310, 30)
            ])

            //scheduler.start()メソッドは、テスト対象となるObservableを作成し、
            //作成されたObservableにオブザーバをサブスクライブさせ、
            //最後に破棄するという一連の流れを実行します。
            //scheduler.start()メソッドには、Observable作成を行うクロージャと、
            //Observableの作成、サブスクライブ、破棄それぞれを実行する時刻を指定することが出来ます。
            let res = scheduler.start(created: 100, subscribed: 200, disposed: 1000) {
                xs.map { $0 * 2 }
            }

            //最後に、オブザーバに通知されたイベントの検証を行います。
            //res.eventsには、オブザーバが受信したイベントの時刻および要素が記録されていますので、
            //想定通りのイベントが通知されているかをここで検証することが出来ます。
            expect(res.events).to(equal([
                Recorded.next(210, 40),
                Recorded.next(310, 60)
            ]))

            //今回のテスト対象はmapオペレーターです。
            //Observableの作成コードをxs.map { $0 * 2 }としているので、
            //オブザーバが受け取る要素はオリジナルの要素の2倍の数値となっているはずです。

            //検証コードを見ると、時刻210と310のイベントしかありません。
            //これは、HotObservableを使用しているためです。
            //HotObservableはイベントをリプレイしません。
            //オブザーバーは時刻200にサブスクライブしているため、その前の時刻110に発行されたイベントは受け取れないのです。


        }

        //HotObservable + startパターンとの違いは、scheduler.createColdObservable()を使っているところです。
        //こちらの場合、テスト対象となるObservableはColdObservableとなります。
        //ColdObservableなので、オブザーバがサブスクライブするタイミングに関わらず、
        //オブザーバはすべてのイベントを受信することができます。
        //検証コードを見てみると、想定通りすべてのイベントが受信できていることがわかります。

        //一方で、イベントを受信した時刻はHotObservableのときとは少し違います。
        //ColdObservableでは、オブザーバがサブスクライブしてからイベントを発行するまでの遅延時間を指定するようです。
        //今回、オブザーバは時刻200にサブスクライブしており、最初のイベントを発行するまでの遅延時間は110になっているので、
        //オブザーバは時刻310に最初のイベントを受信しています。
        it("ColdObservable + start") {
            let xs = scheduler.createColdObservable([
                Recorded.next(110, 10),
                Recorded.next(210, 20),
                Recorded.next(310, 30)
            ])
            
            let res = scheduler.start(created: 100, subscribed: 200, disposed: 1000) {
                xs.map { $0 * 2 }
            }
            
            expect(res.events).to(equal([
                Recorded.next(310, 20),
                Recorded.next(410, 40),
                Recorded.next(510, 60)
            ]))
        }


        //HotObservable + scheduleAt + start パターン
        it("HotObservable + scheduleAt + start") {
            let xs = scheduler.createHotObservable([
                Recorded.next(110, 10),
                Recorded.next(210, 20),
                Recorded.next(310, 30)
            ])

            //scheduler.createObserver()は、オブザーバを作成します。
            //このオブザーバはRxTestが提供するTestableObserverというクラスのインスタンスで、Observableが発行したイベントの時刻と要素を記録することができます。
            //これまでに出てきた変数resは、実はTestableObserverであり、scheduler.start()関数が内部的に作成していたものです。
            let observer = scheduler.createObserver(Int.self)

            //scheduler.scheduleAt()は、指定した時刻に引数として渡されたクロージャを実行します。
            //ここでは、時刻200にオブザーバをサブスクライブさせています。
            scheduler.scheduleAt(200) {
                xs.map { $0 * 2 }.subscribe(observer).disposed(by: disposeBag)
            }

            //scheduler.start()は、今までのそれとは違うもので、TestSchedulerが管理している仮想時間を開始する関数です。
            //これを実行することで、指定時刻にObservableがイベントを発行したり、scheduler.scheduleAt()で指定されたクロージャが実行されたりします。
            scheduler.start()

            expect(observer.events).to(equal([
                Recorded.next(210, 40),
                Recorded.next(310, 60)
            ]))
        }

        //HotObservable + scheduleAt + startパターンのColdObservable版です。
        //やっていることはColdObservable + startパターンと同じです。
        it("ColdObservable + scheduleAt + start") {
            let xs = scheduler.createColdObservable([
                Recorded.next(110, 10),
                Recorded.next(210, 20),
                Recorded.next(310, 30)
            ])
            
            let observer = scheduler.createObserver(Int.self)
            
            scheduler.scheduleAt(200) {
                xs.map { $0 * 2 }.subscribe(observer).disposed(by: disposeBag)
            }
            
            scheduler.start()
            
            expect(observer.events).to(equal([
                Recorded.next(310, 20),
                Recorded.next(410, 40),
                Recorded.next(510, 60)
            ]))
        }

        //RxBlockingが提供するtoBlocking()を活用したパターンです。
        //APIクライアントの関数など、イベントが非同期に発行されるObservableを返す関数をテストするときに有効です。
        it("Blocking") {
            // 非同期にイベントが発行されるObservable
            let observable = Observable.of(10, 20, 30)
                .map { $0 * 2 }
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))

            //toBlocking()は通常のObservableをBlockingObservableに変換します。
            //BlockingObservableは、completedイベントが発行されるまでカレントスレッドつまりここではメインスレッドをブロックします。
            //これにより、非同期に発行されるイベントであっても簡単に要素の検証ができます。
            //BlockingObservableは、要素の検証行うために5つのメソッドを用意しています。
            let blocking = observable.toBlocking()

            //first()とlast()は、Observableが発行した最初と最後の要素を返します
            expect(try! blocking.first()).to(equal(20))
            expect(try! blocking.last()).to(equal(60))
            //toArray()は、Observableが発行したすべてのイベントの要素を返します。
            expect(try! blocking.toArray()).to(equal([20, 40, 60]))
            //single()は、Observableが１つのイベントだけを発行した場合に、その要素を返します。
            //イベントが２つ以上発行された場合は例外をスローします。
            expect { try blocking.single() }.to(throwError(RxError.moreThanOneElement))

            //materialize()は、MaterializedSequenceResultというEnumを返します。
            //Observableがcompletedしたのかfailedしたのかを検証することができます。
            let materialized = blocking.materialize()
            if case let .completed(elements) = materialized {
                expect(elements).to(equal([20, 40, 60]))
            } else {
                fail("expected completed but got \(materialized)")
            }

            //なお、toBlocking()を使う場合、scheduler.createHotObservable()とscheduler.createColdObservable()で生成したObservable(TestableObservable)は使用できません。
            //TestableObservableに対してtoBlocking()を呼ぶと、いつまでたってもテストが終了しません。

        }
        
        xit("Don't do this") {
            let xs = scheduler.createHotObservable([
                Recorded.next(110, 10),
                Recorded.next(210, 20),
                Recorded.next(310, 30),
                Recorded.completed(40)
            ])
            
            // ブロックされたままになりテストが終了しない
            expect(try! xs.toBlocking().toArray()).to(equal([10, 20, 30]))
        }
    }
}
