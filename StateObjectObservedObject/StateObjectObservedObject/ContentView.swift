//
//  ContentView.swift
//  StateObjectObservedObject
//
//  Created by yoshiiikoba on 2021/10/28.
//

import SwiftUI

struct ContentView: View {
    @State var counter = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            HStack {
                Text("counter: \(counter)")
                Button("+") {
                    counter += 1
                }
            }
            StateObjectCounter()
            ObservedObjectCounter()
        }
    }
}

final class Counter: ObservableObject {
    @Published var number = 0
}

struct StateObjectCounter: View {
    @StateObject private var counter = Counter()
    var body: some View {
        HStack {
            Text("StateObjectCounter: \(counter.number)")
            Button("+") {
                counter.number += 1
            }
        }
    }
}

struct ObservedObjectCounter: View {
    @ObservedObject private var counter = Counter()
    
    var body: some View {
        HStack {
            Text("OvservedObjectCounter: \(counter.number)")
            Button("+") {
                counter.number += 1
            }
        }
    }
}
