//
//  ContentView.swift
//  SwiftUINavigationView
//
//  Created by Swift-Beginners on 2021/06/04.
//

import SwiftUI

struct ContentView: View {
    @State private var showNavigationView1: Bool = false

    var body: some View {
        VStack {
            Button(action:{showNavigationView1.toggle()}) {
                Text("NavigationView1")
            }
            .sheet(isPresented: $showNavigationView1, content: {
                NavigationView1()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
