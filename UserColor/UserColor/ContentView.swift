//
//  ContentView.swift
//  UserColor
//
//  Created by Swift-Beginners on 2021/05/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("usercolor")
            Text("Hello, world!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
