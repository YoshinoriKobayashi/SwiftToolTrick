//
//  ContentView.swift
//  DebugLog
//
//  Created by yoshiiikoba on 2022/02/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        DebugView(message: "エラー")
        Rectangle()
            .frame(width: 300, height: 300)
            .background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
