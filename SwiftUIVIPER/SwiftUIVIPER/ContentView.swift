//
//  ContentView.swift
//  SwiftUIVIPER
//
//  Created by Yoshinori Kobayashi on 2023/04/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TodoView(presenter: TodoPresenter(interactor: TodoInteractor()))
    }
}
