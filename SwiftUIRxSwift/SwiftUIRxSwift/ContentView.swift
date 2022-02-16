//
//  ContentView.swift
//  SwiftUIRxSwift
//
//  Created by kobayashi on 2022/02/16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        Button("RxSwift") {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
