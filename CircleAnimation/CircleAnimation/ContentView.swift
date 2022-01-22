//
//  ContentView.swift
//  CircleAnimation
//
//  Created by yoshiiikoba on 2021/10/25.
//

import SwiftUI


struct ContentView: View {
    @State var fill: CGFloat = 0.5
    @State var timer:Timer?
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .stroke(Color.red,style:StrokeStyle(lineWidth:20))
                    .opacity(0.2)
                Circle()
                    .trim(from:0.0,to:self.fill)
                    .stroke(Color.red,style:StrokeStyle(lineWidth:20,lineCap:.round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration:1))
            }
            .frame(width: 300, height: 300)
            .onTapGesture {
                self.fill = 0
                // すでに動いているタイマーは停止
                if let workingTimer = self.timer{
                    workingTimer.invalidate()
                }
                
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    self.fill = 1
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
