//
//  ContentView.swift
//  PageViewController
//
//  Created by yoshiiikoba on 2021/11/04.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $selection) {
                Text("Page1").tag(0)
                Text("Page2").tag(1)
                Text("Page3").tag(2)
            }.pickerStyle(.segmented)
            
            TabView(selection: $selection) {
                Text("Page 1")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .tag(0)
                Text("Page 2")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .tag(1)
                Text("Page 3")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
