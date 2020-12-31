//
//  ContentView.swift
//  TaskApp
//
//  Created by Yoshinori Kobayashi on 2020/10/23.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        Home()
    }
}

