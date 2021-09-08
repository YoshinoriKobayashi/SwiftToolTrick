//
//  ContentView.swift
//  SwiftUIViewlLayout
//
//  Created by yoshiiikoba on 2021/09/08.
//

import SwiftUI

// 参考サイト
// VStack、ZStack、HStack
// https://capibara1969.com/1754/#toc11

struct ContentView: View {
    var body: some View {
        VStack {
            Text("アプリ開発")
                .font(.largeTitle)
                .frame(width: 200)
                .background(Color.blue)
            Divider()
            Text("SwiftUI")
                .font(.largeTitle)
                .frame(width: 200)
                .background(Color.green)
            Divider()
            Spacer()
        }
        HStack {
            Text("SwiftUI")
                .font(.largeTitle)
                .frame(width: 150)
                .background(Color.green)
            Text("Apple")
                .font(.largeTitle)
                .frame(width: 200)
                .background(Color.yellow)
        }
        ZStack {
            Image("seaImage")
                .resizable()
                .scaledToFit()
            Text("夏だ！海だ！")
                .font(.largeTitle)
                .frame(width: 300)
                .background(Color.blue)
        }
        ZStack(alignment: .topTrailing) {
            Image("seaImage")
                .resizable()
                .scaledToFit()
            Text("夏だ！海だ！")
                .font(.largeTitle)
                .frame(width: 300)
                .background(Color.blue)
                .offset(y:0)
                .border(Color.red, width: 2) // フレームを可視化
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
