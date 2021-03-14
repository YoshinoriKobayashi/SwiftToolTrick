//
//  SplitView.swift
//  SwiftUICheatSheet
//
//  Created by Swift-Beginners on 2021/03/14.
//

import SwiftUI

struct SplitView: View {
    var body: some View {
        NavigationView {
            ListView()
            DetailView()
        }
    }
}
// Put them in a new .swift file!
struct ListView: View {
    var body: some View {
        List(0..<5) { item in
            NavigationLink(
                destination: DetailView()) {
                Text("NavigationLink Menu")
            }
        }.navigationBarTitle("Hello,List!")
    }
}
struct DetailView: View {
    var body: some View {
        Text("Hello 😊")
    }
}


struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}
