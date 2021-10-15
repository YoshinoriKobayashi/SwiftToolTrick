//
//  ContentView.swift
//  GeometryReadertotheRescue
//
//  Created by yoshiiikoba on 2021/10/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello There!")
            MyRectangle()
        }.frame(width: 150,height: 100).border(Color.black)
    }
}

struct MyRectangle: View {
    var body: some View {
//        // GeometryReaderなし
//        Rectangle().fill(Color.blue)
        
        GeometryReader { geometory in 
            // Rectangleを基準にViewを指定
            Rectangle()
                .path(in: CGRect(x: geometory.size.width + 5,
                                 y:0,
                                 width: geometory.size.width / 2.0,
                                 height: geometory.size.height / 2.0))
                .fill(Color.blue)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
