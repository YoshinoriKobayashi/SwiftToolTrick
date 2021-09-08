//
//  ContentView.swift
//  ViewHierarchy
//
//  Created by yoshiiikoba on 2021/08/2
//

import SwiftUI

struct ContentView: View {
    @State private var scount = 0
 
    init() {
        print("親のinit")
    }
    var body: some View {
        VStack {
            Text("\(scount)")
                .font(.largeTitle)
            Button(action: {
                scount = scount + 1
            }) {
                Text("親カウントアップ")
            }
            Count2()
        }
        .padding()
        .background(scount % 2 == 0 ? Color.green : Color.gray)
        .onAppear() {
            print("親のonAppear")
        }
        .onDisappear() {
            print("親のonDisappear")
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
