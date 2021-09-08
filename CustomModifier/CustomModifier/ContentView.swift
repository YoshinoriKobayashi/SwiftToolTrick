//
//  ContentView.swift
//  CustomModifier
//
//  Created by yoshiiikoba on 2021/08/20.
//

import SwiftUI

// https://capibara1969.com/1520/
struct ContentView: View {
    var body: some View {
        Text("カビ通信")
            // カスタムModifierの使用
            .modifier(MyTitle(color: .blue))
    }
}

// カスタムModifier
struct MyTitle: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
