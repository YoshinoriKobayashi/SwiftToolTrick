//
//  ContentView.swift
//  SwiftUIAsyncImage
//
//  Created by kobayashi on 2022/05/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            ForEach(0..<10) { _ in
                AsyncImage(url: URL(string: "https://ticklecode.com/wp/wp-content/uploads/2016/06/logo_ticklecode.png")) { phase in
//                    if let iamge = phase.image {
//                        Image
//                    } else if phase.error != nil {
//                        Color.red
//                    } else {
//                        Color.blue
//                    }
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
