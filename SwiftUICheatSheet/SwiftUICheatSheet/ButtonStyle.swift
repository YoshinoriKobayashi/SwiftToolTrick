//
//  Button.swift
//  SwiftUICheatSheet
//
//  Created by Swift-Beginners on 2021/03/14.
//

import SwiftUI

struct ButtonStyle: View {
    var body: some View {
        Button(action: {
            print("Button action")
        }) {
            HStack {
                Image(systemName: "bookmark.fill")
                Text("Bookmark")
            }
        }
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyle()
    }
}
