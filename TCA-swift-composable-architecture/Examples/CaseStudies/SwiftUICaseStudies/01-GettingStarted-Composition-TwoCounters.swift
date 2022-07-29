import ComposableArchitecture
import SwiftUI

private let readMe = """
  この画面では、reducerの `pullback` と `combine` 演算子、およびストアの `scope` 演算子を用いて、小さな機能をより大きな機能に合成する方法を示しています。
  カウンタースクリーンの領域を再利用し、より大きな領域の中に二重に埋め込んでいるのです。
  """


struct TwoCountersState: Equatable {
    var counter1 = CounterState()
    var counter2 = CounterState()
}

enum TwoCountersAction {
    case counter1(CounterAction)
    case counter2(CounterAction)
}

struct TwoCountersEnvironment {}


let twoCountersReducer = Reducer<TwoCountersState, TwoCountersAction, TwoCountersEnvironment>
// 
    .combine(
        // ローカルのstate、action、environmentに対して動作するreducerを、グローバルなstate、action、environmentに対して動作するreducerに変換します。
        counterReducer.pullback(
            state: \TwoCountersState.counter1,
            action: /TwoCountersAction.counter1,
            environment: { _ in CounterEnvironment() }
        ),
        counterReducer.pullback(
            state: \TwoCountersState.counter2,
            action: /TwoCountersAction.counter2,
            environment: { _ in CounterEnvironment() }
        )
    )

struct TwoCountersView: View {
    let store: Store<TwoCountersState, TwoCountersAction>
    
    var body: some View {
        Form {
            Section {
                AboutView(readMe: readMe)
            }
            
            HStack {
                Text("Counter 1")
                Spacer()
                CounterView(
                    // 部品のViewを使う
                    store: self.store.scope(state: \.counter1, action: TwoCountersAction.counter1)
                )
            }
            
            HStack {
                Text("Counter 2")
                Spacer()
                CounterView(
                    // 部品のViewを使う
                    store: self.store.scope(state: \.counter2, action: TwoCountersAction.counter2)
                )
            }
        }
        .buttonStyle(.borderless)
        .navigationTitle("Two counter demo")
    }
}

struct TwoCountersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TwoCountersView(
                store: Store(
                    initialState: TwoCountersState(),
                    reducer: twoCountersReducer,
                    environment: TwoCountersEnvironment()
                )
            )
        }
    }
}
