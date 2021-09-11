//
//  ContentView.swift
//  UserColorSwiftUI
//
//  Created by yoshiiikoba on 2021/09/11.
//

import SwiftUI

struct ContentView: View {
var body: some View {
    ZStack{
        Text("Hello, world!")
            .padding()
            .foregroundColor(Color.customFontColor)
    }
    .background(Color.customBackgroundColor)

}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
