import ComposableArchitecture
import SwiftUI

private let readMe = """
    この画面は、コンポーザブル・アーキテクチャにおいて、複数の独立した画面がどのように状態を共有できるかを示すものである。各タブはそれ自身の状態を管理し、別々のモジュールになることができますが、1つのタブでの変更は他のタブに即座に反映されます。

  このタブは独自の状態を持ち、カウント値を増減させることができるほか、現在のカウントがプライムであるかどうかを尋ねる際に設定されるアラート値で構成されています。

  内部では、最小・最大カウントや発生したカウントイベントの総数など、さまざまな統計情報を記録している。それらの状態は、他のタブで見ることができ、統計情報は他のタブからリセットすることができます。

  """

struct SharedState: Equatable {
  var counter = CounterState()
  var currentTab = Tab.counter

  enum Tab { case counter, profile }

  struct CounterState: Equatable {
    var alert: AlertState<SharedStateAction.CounterAction>?
    var count = 0
    var maxCount = 0
    var minCount = 0
    var numberOfCounts = 0
  }

  // ProfileStateは、気になる部分を取得・設定することで、CounterStateから派生させることができます。これにより、プロファイル機能は、全体ではなく、アプリの状態のサブセットで動作するようになります。
  var profile: ProfileState {
    get {
      ProfileState(
        currentTab: self.currentTab,
        count: self.counter.count,
        maxCount: self.counter.maxCount,
        minCount: self.counter.minCount,
        numberOfCounts: self.counter.numberOfCounts
      )
    }
    set {
      self.currentTab = newValue.currentTab
      self.counter.count = newValue.count
      self.counter.maxCount = newValue.maxCount
      self.counter.minCount = newValue.minCount
      self.counter.numberOfCounts = newValue.numberOfCounts
    }
  }

  struct ProfileState: Equatable {
    private(set) var currentTab: Tab
    private(set) var count = 0
    private(set) var maxCount: Int
    private(set) var minCount: Int
    private(set) var numberOfCounts: Int

    fileprivate mutating func resetCount() {
      self.currentTab = .counter
      self.count = 0
      self.maxCount = 0
      self.minCount = 0
      self.numberOfCounts = 0
    }
  }
}

enum SharedStateAction: Equatable {
  case counter(CounterAction)
  case profile(ProfileAction)
  case selectTab(SharedState.Tab)

  enum CounterAction: Equatable {
    case alertDismissed
    case decrementButtonTapped
    case incrementButtonTapped
    case isPrimeButtonTapped
  }

  enum ProfileAction: Equatable {
    case resetCounterButtonTapped
  }
}

let sharedStateCounterReducer = Reducer<
  SharedState.CounterState, SharedStateAction.CounterAction, Void
> { state, action, _ in
  switch action {
  case .alertDismissed:
    state.alert = nil
    return .none

  case .decrementButtonTapped:
    state.count -= 1
    state.numberOfCounts += 1
    state.minCount = min(state.minCount, state.count)
    return .none

  case .incrementButtonTapped:
    state.count += 1
    state.numberOfCounts += 1
    state.maxCount = max(state.maxCount, state.count)
    return .none

  case .isPrimeButtonTapped:
    state.alert = AlertState(
      title: TextState(
        isPrime(state.count)
          ? "👍 The number \(state.count) is prime!"
          : "👎 The number \(state.count) is not prime :("
      )
    )
    return .none
  }
}

let sharedStateProfileReducer = Reducer<
  SharedState.ProfileState, SharedStateAction.ProfileAction, Void
> { state, action, _ in
  switch action {
  case .resetCounterButtonTapped:
    state.resetCount()
    return .none
  }
}

let sharedStateReducer = Reducer<SharedState, SharedStateAction, Void>.combine(
  sharedStateCounterReducer.pullback(
    state: \SharedState.counter,
    action: /SharedStateAction.counter,
    environment: { _ in () }
  ),
  sharedStateProfileReducer.pullback(
    state: \SharedState.profile,
    action: /SharedStateAction.profile,
    environment: { _ in () }
  ),
  Reducer { state, action, _ in
    switch action {
    case .counter, .profile:
      return .none
    case let .selectTab(tab):
      state.currentTab = tab
      return .none
    }
  }
)

struct SharedStateView: View {
  let store: Store<SharedState, SharedStateAction>

  var body: some View {
    WithViewStore(self.store.scope(state: \.currentTab)) { viewStore in
      VStack {
        Picker(
          "Tab",
          selection: viewStore.binding(send: SharedStateAction.selectTab) // 
        ) {
          Text("Counter")
            .tag(SharedState.Tab.counter)

          Text("Profile")
            .tag(SharedState.Tab.profile)
        }
        .pickerStyle(.segmented)

        if viewStore.state == .counter {
          SharedStateCounterView(
            store: self.store.scope(state: \.counter, action: SharedStateAction.counter))
        }

        if viewStore.state == .profile {
          SharedStateProfileView(
            store: self.store.scope(state: \.profile, action: SharedStateAction.profile))
        }

        Spacer()
      }
    }
    .padding()
  }
}

struct SharedStateCounterView: View {
  let store: Store<SharedState.CounterState, SharedStateAction.CounterAction>

  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(spacing: 64) {
        Text(template: readMe, .caption)

        VStack(spacing: 16) {
          HStack {
            Button {
              viewStore.send(.decrementButtonTapped)
            } label: {
              Image(systemName: "minus")
            }

            Text("\(viewStore.count)")
              .monospacedDigit()

            Button {
              viewStore.send(.incrementButtonTapped)
            } label: {
              Image(systemName: "plus")
            }
          }

          Button("Is this prime?") { viewStore.send(.isPrimeButtonTapped) }
        }
      }
      .padding(.top)
      .navigationTitle("Shared State Demo")
      .alert(self.store.scope(state: \.alert), dismiss: .alertDismissed)
    }
  }
}

struct SharedStateProfileView: View {
  let store: Store<SharedState.ProfileState, SharedStateAction.ProfileAction>

  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(spacing: 64) {
        Text(
          template: """
            このタブは、前のタブからのStateを表示し、すべてをStateを0に戻すことが可能です。

            これは、各画面がそのstateを最も意味のある方法でモデル化し、かつ独立した画面間で状態や変異を共有することが可能であることを示しています。
            """,
          .caption
        )

        VStack(spacing: 16) {
          Text("Current count: \(viewStore.count)")
          Text("Max count: \(viewStore.maxCount)")
          Text("Min count: \(viewStore.minCount)")
          Text("Total number of count events: \(viewStore.numberOfCounts)")
          Button("Reset") { viewStore.send(.resetCounterButtonTapped) }
        }
      }
      .padding(.top)
      .navigationTitle("Profile")
    }
  }
}

// MARK: - SwiftUI previews

struct SharedState_Previews: PreviewProvider {
  static var previews: some View {
    SharedStateView(
      store: Store(
        initialState: SharedState(),
        reducer: sharedStateReducer,
        environment: ()
      )
    )
  }
}

// MARK: - Private helpers

/// Checks if a number is prime or not.
private func isPrime(_ p: Int) -> Bool {
  if p <= 1 { return false }
  if p <= 3 { return true }
  for i in 2...Int(sqrtf(Float(p))) {
    if p % i == 0 { return false }
  }
  return true
}
