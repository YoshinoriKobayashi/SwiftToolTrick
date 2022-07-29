import ComposableArchitecture
import SwiftUI

private let readMe = """
  この画面は、Composable Architectureの基本を、典型的なcounter applicationで示したものです。アプリケーションの基本を示します。
  
  アプリケーションのドメインは、アプリケーションの変更可能な状態に対応す る単純なデータ型を使用してモデル化されます。の状態、およびその状態や外界に影響を与える可能性のあるアクションに対応する単純なデータ型を使用して、アプリケーションの領域をモデル化します。
  """

// 変化する変数
struct CounterState: Equatable {
    var count = 0
}

// 画面のアクション
enum CounterAction: Equatable {
    case decrementButtonTapped
    case incrementButtonTapped
}

struct CounterEnvironment {}

// ドメイン（counter）で処理をかく
// state：CounterSate型
// action:CounterAction型
// このReducerでイベントに応じて実行する処理をまとめている。
let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, _ in
    switch action {
    case .decrementButtonTapped:
        state.count -= 1
        return .none
    case .incrementButtonTapped:
        state.count += 1
        return .none
    }
}

struct CounterView: View {
    // 
    let store: Store<CounterState, CounterAction>
    
    var body: some View {
        // ストアの状態からビューを計算するために、ストアを観測可能なビューストアに変換する構造体です。ストアの状態からビューを計算するために、ストアを観測可能なビューストアに変換する構造体です。
        WithViewStore(self.store) { viewStore in
            HStack {
                Button {
                    // タップイベントの送信
                    viewStore.send(.decrementButtonTapped)
                } label: {
                    Image(systemName: "minus")
                }
                
                Text("\(viewStore.count)")
                    .monospacedDigit()
                
                Button {
                    // タップイベントの送信
                    viewStore.send(.incrementButtonTapped)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct CounterDemoView: View {
    let store: Store<CounterState, CounterAction>
    
    var body: some View {
        Form {
            Section {
                AboutView(readMe: readMe)
            }
            
            Section {
                CounterView(store: self.store)
                    .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(.borderless)
        .navigationTitle("Counter demo")
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CounterDemoView(
                store: Store(
                    initialState: CounterState(),
                    reducer: counterReducer,
                    environment: CounterEnvironment()
                )
            )
        }
    }
}
