//
//  ContentView.swift
//  SwiftUIAnimatedRun
//
//  Created by Swift-Beginners on 2021/05/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Rating()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Rating: View  {

    // slider Value...
    @State var value : CGFloat = 0.5

    var body: some View {
        VStack {
            Text("Do you like this conversation?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.top,20)

            Spacer(minLength: 0)

            HStack(spacing: 25) {
                ForEach(1...2,id \.self) {_ in
                    ZStack {
                        Eyes()
                            .stroke(Color.black,GL_LINE_WIDTH: 3)
                            .frame(width: 100)

                        Eyes(value: value)
                            .stroke(Color.black,lineWidth: 3)
                            .frame(width: 100)
                            .rotationEffect(.init(degress: 180))
                            .offset(y)

                    }
                }
            }

        }
    }
}
