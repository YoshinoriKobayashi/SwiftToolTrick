//
//  GaugeSample.swift
//  SwiftUIWWDC2022
//
//  Created by kobayashi on 2022/06/21.
//

import SwiftUI

struct GaugeSample: View {

    let displayedProgress = 0.31

    var body: some View {
        VStack {
            Gauge(value: 23, in: 17...29) {
                Text("℃")
            } currentValueLabel: {
                Text("23")
            }
            .gaugeStyle(.accessoryCircular)
            .tint(Gradient(colors: [.green, .yellow, .orange]))
            Spacer()
            Gauge(value: displayedProgress) {
                Text("%")
            } currentValueLabel: {
                Text("\(Int(displayedProgress * 100))")
                    .font(.caption)
            }
            .gaugeStyle(.accessoryCircular)
            Spacer()
            Gauge(value: displayedProgress) {
                Text("Default Gauge")
            }
            Spacer()
            Gauge(value: 50, in: 0...100) {
                Text("Default Gauge")
            } currentValueLabel: {
                Text("50%")
            } minimumValueLabel: {
                Text("0%")
            } maximumValueLabel: {
                Text("100%")
            }
            Spacer()
        }

    }
}

struct GaugeSample_Previews: PreviewProvider {
    static var previews: some View {
        GaugeSample()
    }
}
