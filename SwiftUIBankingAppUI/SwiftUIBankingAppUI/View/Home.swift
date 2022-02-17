//
//  Home.swift
//  SwiftUIBankingAppUI
//
//  Created by yoshiiikoba on 2022/02/11.
//

import SwiftUI

struct Home: View {
    // MARK: Sample Colors
    @State var colors: [ColorGrid] = [
        ColorGrid(hexValue: "#15654B", color: Color("Green")),
        ColorGrid(hexValue: "#DAA4FF", color: Color("Violet")),
        ColorGrid(hexValue: "#FFD90A", color: Color("Yellow")),
        ColorGrid(hexValue: "#FE9ECA", color: Color("Pink")),
        ColorGrid(hexValue: "#FB3272", color: Color("Orange")),
        ColorGrid(hexValue: "#4460EE", color: Color("Blue"))
    ]

    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .hLeading()
                
                Button {
                    
                } label: {
                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }

            }
            .padding()
            CreaditCard()
        }
        .vTop()
        .hCenter()
        .background(Color("BG"))
        .preferredColorScheme(.dark)
    }
    
    // MARK: Animated Credit Cart
//    @ViewBuilder
    func CreaditCard() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("Pink"))
            VStack {
                HStack {
                    ForEach(1...4, id: \.self) {_ in
                        Circle()
                            .fill(.white)
                            .frame(width: 6, height: 6)
                    }
                    Text("7864")
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                }
                .hLeading()
                
                HStack(spacing: -12) {
                    Text("Jenna Ezarik")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .hLeading()
                    
                    Circle()
                        .stroke(.white,lineWidth: 1)
                        .frame(width: 30, height: 30)
                    
                    Circle()
                        .stroke(.white,lineWidth: 1)
                        .frame(width: 30, height: 30)
                }
                .vBottom()
            }
            .padding(.vertical,20)
            padding(.horizontal)
            .vTop()
            .hLeading()
            
            // MARK: Top Ring
            Circle()
                .stroke(Color.white.opacity(0.5),lineWidth: 18)
                .offset(x: 130,y: -120)
        }
        .frame(height: 250)
        .padding()
        .clipped()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// MARK: Extensions for Making UI Desin Faster
extension View{
    func hLeading() -> some View{
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing() -> some View{
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter() -> some View{
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    func vCenter() -> some View{
        self.frame(maxHeight: .infinity, alignment: .center)
    }
    func vTop() -> some View{
        self.frame(maxHeight: .infinity, alignment: .top)
    }
    func vBottom() -> some View{
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
}
