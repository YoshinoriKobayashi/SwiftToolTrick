//
//  ContentView.swift
//  SwiftUITabView
//
//  Created by yoshiiikoba on 2022/02/23.
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
            }.pickerStyle(SegmentedPickerStyle())
            
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
        .onChange(of: selection) { newValue in
            print("newValue = [\(newValue)]")
            selection = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
