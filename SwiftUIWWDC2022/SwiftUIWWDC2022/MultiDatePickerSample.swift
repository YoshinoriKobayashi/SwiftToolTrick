//
//  MultiDatePickerSample.swift
//  SwiftUIWWDC2022
//
//  Created by kobayashi on 2022/06/21.
//

import SwiftUI

struct MultipleDatePickerSample: View {
    @State private var userSelectedDates: Set<DateComponents> = []

    var body: some View {
        Form {
            MultiDatePicker("Select some dates", selection: $userSelectedDates)
            Section {
                Text("Selected dates:\(userSelectedDates.description)")
            }
        }

    }
}

struct MultipleDatePickerSample_Previews: PreviewProvider {
    static var previews: some View {
        MultipleDatePickerSample()
    }
}
