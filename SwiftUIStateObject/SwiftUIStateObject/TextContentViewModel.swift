//
//  TextContentViewModel.swift
//  SwiftUIStateObject
//
//  Created by Yoshinori Kobayashi on 2022/09/14.
//

import SwiftUI

final class TextContentViewModel: ObservableObject {
    @Published var text = "Hello @StateObject"
    
    init() { print("TextContentViewModel init") }
    deinit { print("TextContentViewModel deinit") }
}
