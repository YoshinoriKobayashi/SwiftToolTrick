//
//  ScannerViewModel.swift
//  SwiftUIQRCodeAVCapture
//
//  Created by kobayashi on 2022/06/03.

import Foundation

class ScannerViewModel: ObservableObject {
    let scanInterval: Double = 1.0

    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = "Qr-code goes here"

    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}
