//
//  ContentView.swift
//  NavigationViewList
//
//  Created by yoshiiikoba on 2021/10/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Text("🍊").font(.system(size: 200)))  {
                    Text("オレンジ")
                }               
                NavigationLink(destination: Text("🍎").font(.system(size: 200))) {
                    Text("りんご")
                }
                NavigationLink(destination: Text("🍋").font(.system(size: 200))) {
                    Text("レモン")
                }                
                NavigationLink(destination: Text("🍓").font(.system(size: 200))) {
                    Text("いちご")
                }                
            }
            .navigationTitle("フルーツを選ぶ")
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
