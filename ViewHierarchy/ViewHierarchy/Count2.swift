//
//  Count2.swift
//  ViewHierarchy
//
//  Created by yoshiiikoba on 2021/08/21.
//

import SwiftUI

struct Count2: View {
    @State private var scount:Int = 0
 
    init() {
        print("子のinit")
    }
    var body: some View {
        VStack {
            Text("\(scount)")
                .font(.largeTitle)
            Button(action: {
                scount = scount + 1
            }) {
                Text("子カウントアップ")
                    .foregroundColor(Color.white)
            }
        }
        .padding()
        .background(scount % 2 == 0 ? Color.red : Color.blue)
        .onAppear() {
            print("子のonAppear")
        }
        .onDisappear() {
            print("子のonDisappear")
        }
    }

}

struct Count2_Previews: PreviewProvider {
    static var previews: some View {
        Count2()
    }
}
