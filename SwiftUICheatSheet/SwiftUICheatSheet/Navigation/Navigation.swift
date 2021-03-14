//
//  Navigation.swift
//  SwiftUICheatSheet
//
//  Created by Swift-Beginners on 2021/03/14.
//

import SwiftUI

struct Navigation: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: SubContentView()) { Text("Next View") }
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
