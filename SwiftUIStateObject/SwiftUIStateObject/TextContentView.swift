//
//  TextContentView.swift
//  SwiftUIStateObject
//
//  Created by Yoshinori Kobayashi on 2022/09/14.
//

import SwiftUI

struct TextContentView: View {
//     @StateObject private var viewModel: TextContentViewModel
    @StateObject var viewModel: TextContentViewModel
    
//    init(viewModel: TextContentViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//        print("TextContentView init")
//    }
    
    var body: some View {
        Text(viewModel.text)
            .onAppear() {
//                _ = viewModel
            }
    }
}
//
//struct TextContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextContentView()
//    }
//}
