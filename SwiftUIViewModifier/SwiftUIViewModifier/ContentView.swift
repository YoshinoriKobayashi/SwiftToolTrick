//
//  ContentView.swift
//  SwiftUIViewModifier
//
//  Created by yoshiiikoba on 2022/02/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
Image("earth")
    .resizable()                        // サイズ変更
    .frame(width: 300, height: 300)     // フレーム
    .clipShape(Circle())                // 円形に切り抜き

    // 枠線を重ねる
    .overlay(Circle()
        .stroke(Color.white, lineWidth: 30)  // 白い線
        .shadow(radius: 10))                 // 影をつける

    .overlay(Text("地球")          // 文字
        .font(.largeTitle)        // 文字大きさ
        .fontWeight(.black)       // 文字太さ
        .foregroundColor(.red)    // 文字色
        .offset(y:-40)            // 上に配置
         ,alignment: .bottom)     // 下に配置
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
