//
//  ContentView.swift
//  SwiftUIButtonTapArea
//
//  Created by Swift-Beginners on 2022/09/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button { 
        } label: { 
            // タップできる範囲はラベルのViewサイズで決まる。
            Text("Sign In")
                .foregroundColor(Color.white)
                .padding(30)
                .background(Color.blue)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
