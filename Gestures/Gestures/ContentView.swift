//
//  ContentView.swift
//  Gestures
//
//  Created by yoshiiikoba on 2021/10/08.
//

import SwiftUI

struct ContentView: View {
    @State private var message = "Message"
    // 新しいタップジェスチャー
    let newGesture = TapGesture().onEnded {
        print("Tap on VStack.")
    }
    
    var body: some View {
        VStack(spacing:25) {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 75, height: 75)
                .padding()
                .foregroundColor(.red)
                .onTapGesture { // このジェスチャーが優先される
                    print("Tap on image.")
                }
            Rectangle()
                .fill(Color.blue)
        }
        .gesture(newGesture)  // ここで利用
        .frame(width: 200, height: 200)
        .border(Color.purple)
    }
    

    
    // ====================
    //    @State var tapped = false
    //    
    //    var tap: some Gesture {
    //        TapGesture(count: 1)
    //            .onEnded{_ in self.tapped = !self.tapped}
    //    }
    //    var body: some View {        
    //        Circle()
    //            .fill(self.tapped ? Color.blue : Color.red)
    //            .frame(width: 100, height: 100, alignment: .center)
    //            .gesture(tap)
    //    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
