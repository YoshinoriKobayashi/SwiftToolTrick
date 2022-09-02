import ComposableArchitecture
import SwiftUI

private let readMe = """
  この画面は、いくつかのオプションの子状態の存在に基づいて、ビューを表示したり隠したりする方法を示しています。
  
  親ステートは `CounterState?` 値を保持します。これが `nil` である場合、デフォルトでプレーンテキスト表示になります。しかし、`nil`でない場合は、オプションでないカウンタ状態を操作するカウンタのビューフラグメントを表示します。
  
  Toggle counter state "をタップすると、`nil`と`nil`でないカウンターの状態を切り替えることができます。
  """

struct OptionalBasicsState: Equatable {
    var optionalCounter: CounterState?
}

enum OptionalBasicsAction: Equatable {
    case optionalCounter(CounterAction)
    case toggleCounterButtonTapped
}

struct OptionalBasicsEnvironment {}

let optionalBasicsReducer =
counterReducer
// 非オプショナルなstateに対して動作するreducerを、 オプショナルなstateに対して動作するreducerに変換し、 state が non-nil のときだけ非オプショナルなreducerを実行するようにします。
    .optional()
// ローカルのstate、action、environmentに対して動作するreducerを、グローバルなstate、action、environmentに対して動作するreducerに変換します。
    .pullback(
        state: \.optionalCounter,
        action: /OptionalBasicsAction.optionalCounter,
        environment: { _ in CounterEnvironment() }
    )
// 多くのreducerを1つにまとめ、それぞれのreducerを順番にstateに対して実行し、すべてのeffects（効果）をマージする。
    .combined(
        with: Reducer<
        OptionalBasicsState, OptionalBasicsAction, OptionalBasicsEnvironment
        > { state, action, environment in
            switch action {
            case .toggleCounterButtonTapped:
                state.optionalCounter =
                state.optionalCounter == nil
                ? CounterState()
                : nil
                return .none
            case .optionalCounter:
                return .none
            }
        }
    )

struct OptionalBasicsView: View {
    let store: Store<OptionalBasicsState, OptionalBasicsAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section {
                    AboutView(readMe: readMe)
                }
                
                Button("Toggle counter state") {
                    viewStore.send(.toggleCounterButtonTapped)
                }
                // Storeのnilを判断
                IfLetStore(
                    self.store.scope(
                        state: \.optionalCounter,
                        action: OptionalBasicsAction.optionalCounter
                    ),
                    then: { store in
                        Text(template: "`CounterState` is non-`nil`")
                        CounterView(store: store)
                            .buttonStyle(.borderless)
                            .frame(maxWidth: .infinity)
                    },
                    else: {
                        Text(template: "`CounterState` is `nil`")
                    }
                )
            }
        }
        .navigationTitle("Optional state")
    }
}

struct OptionalBasicsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                OptionalBasicsView(
                    store: Store(
                        initialState: OptionalBasicsState(),
                        reducer: optionalBasicsReducer,
                        environment: OptionalBasicsEnvironment()
                    )
                )
            }
            
            NavigationView {
                OptionalBasicsView(
                    store: Store(
                        initialState: OptionalBasicsState(optionalCounter: CounterState(count: 42)),
                        reducer: optionalBasicsReducer,
                        environment: OptionalBasicsEnvironment()
                    )
                )
            }
        }
    }
}
