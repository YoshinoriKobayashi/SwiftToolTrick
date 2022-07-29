import ComposableArchitecture
import SwiftUI

private let readMe = """
  このファイルは、Composable Architectureにおける双方向バインディングの処理方法について説明するものです。
  
  SwiftUIにおける双方向のバインディングは強力ですが、Composable Architectureの「一方向のデータフロー」の流れに逆らうものでもあります。というのも、何でも好きなときに値を変異させることができるからです。
  
  一方、Composable Architectureでは、mutations（ミューテーション）はStoreにAction を送ることによってのみ発生することが要求されており、これは機能のState （状態）がどのように進化していくかを見る場所が、reducerに一箇所しかないことを意味します。
  
    仕事をするためにバインディングを必要とする SwiftUI コンポーネントは、Composable Architecture で使用することができます。Bindingメソッドを使用することで、ViewStore から Binding を派生させることができます。これにより、コンポーネントをレンダリングする状態や、コンポーネントが変更されたときに送信するアクションを指定することができます。つまり、機能のために一方向のスタイルを使い続けることができるのです。
  
  """

// この画面のステートは、以下のような値を保持しています。
struct BindingBasicsState: Equatable {
    var sliderValue = 5.0
    var stepCount = 10
    var text = ""
    var toggleIsOn = false
}

// Actionにデータ型が定義されている、引数を受ける
enum BindingBasicsAction {
    case sliderValueChanged(Double)
    case stepCountChanged(Int)
    case textChanged(String)
    case toggleChanged(isOn: Bool)
}

struct BindingBasicsEnvironment {}

let bindingBasicsReducer = Reducer<
    BindingBasicsState, BindingBasicsAction, BindingBasicsEnvironment> {
        state, action, _ in
        
        // Actionで引数をうけて、Reducerでその引数を取得して加工している。
        switch action {
        case let .sliderValueChanged(value):
            state.sliderValue = value
            return .none
            
        case let .stepCountChanged(count):
            state.sliderValue = .minimum(state.sliderValue, Double(count))
            state.stepCount = count
            return .none
            
        case let .textChanged(text):
            state.text = text
            return .none
            
        case let .toggleChanged(isOn):
            state.toggleIsOn = isOn
            return .none
        }
    }

struct BindingBasicsView: View {
    let store: Store<BindingBasicsState, BindingBasicsAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section {
                    AboutView(readMe: readMe)
                }
                
                HStack {
                    // Bindinが必要なケースでは、.bindingを使っている
                    TextField(
                        "Type here",
                        text: viewStore.binding(get: \.text, send: BindingBasicsAction.textChanged)
                    )
                    .disableAutocorrection(true)
                    .foregroundStyle(viewStore.toggleIsOn ? Color.secondary : .primary)
                    Text(alternate(viewStore.text))
                }
                .disabled(viewStore.toggleIsOn)
                
                Toggle(
                    "Disable other controls",
                    isOn: viewStore.binding(get: \.toggleIsOn, send: BindingBasicsAction.toggleChanged)
                        .resignFirstResponder()
                )
                
                Stepper(
                    "Max slider value: \(viewStore.stepCount)",
                    value: viewStore.binding(get: \.stepCount, send: BindingBasicsAction.stepCountChanged),
                    in: 0...100
                )
                .disabled(viewStore.toggleIsOn)
                
                HStack {
                    Text("Slider value: \(Int(viewStore.sliderValue))")
                    Slider(
                        value: viewStore.binding(
                            get: \.sliderValue,
                            send: BindingBasicsAction.sliderValueChanged
                        ),
                        in: 0...Double(viewStore.stepCount)
                    )
                    .tint(.accentColor)
                }
                .disabled(viewStore.toggleIsOn)
            }
        }
        .monospacedDigit()
        .navigationTitle("Bindings basics")
    }
}

private func alternate(_ string: String) -> String {
    string
        .enumerated()
        .map { idx, char in
            idx.isMultiple(of: 2)
            ? char.uppercased()
            : char.lowercased()
        }
        .joined()
}

struct BindingBasicsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BindingBasicsView(
                store: Store(
                    initialState: BindingBasicsState(),
                    reducer: bindingBasicsReducer,
                    environment: BindingBasicsEnvironment()
                )
            )
        }
    }
}
