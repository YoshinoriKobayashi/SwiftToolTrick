//
//  BorderedRoundedButtonStyle.swift
//  SwiftUIButtonStyle
//
//  Created by Yoshinori Kobayashi on 2023/05/10.
//

import SwiftUI

struct BorderedRoundedButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat
    
    @Environment(\.isEnabled) var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white)
            .foregroundColor(self.isEnabled ? Color.blue : Color.gray)
            .font(.body.bold())
            .overlay(RoundedRectangle(cornerRadius: self.cornerRadius)
                .stroke(self.isEnabled ? Color.blue : Color.gray, lineWidth: 2))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2))
    }
}
