//
//  ContentView.swift
//  SwiftUIStateObject
//
//  Created by Yoshinori Kobayashi on 2022/09/14.
//

import SwiftUI

struct ContentView: View {
    @State var isOn = false
    
    var body: some View {
        VStack(spacing: 20) {
            TextContentView(viewModel: TextContentViewModel())
            
            // このコードは、ルートビューの階層を変更するものです。したがって、すべての子ビューは、'ContentView'を含めて完全に作成されます。
            if isOn { Text("is on")}
            
            Button("Trigger") { isOn.toggle()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
