//
//  PasteButtonSample.swift
//  SwiftUIWWDC2022
//
//  Created by kobayashi on 2022/06/22.
//

import SwiftUI

struct PasteButtonSample: View {
    @State private var userPastedImageObj: UIImage?

    var body: some View {
        Form {
            // ペーストボードから項目を読み出し、クロージャーに配信するシステムボタンです。
            PasteButton(supportedContentTypes: [.image]) { providers in
                if let firstProvider = providers.first {
                    _  =  firstProvider.loadDataRepresentation(for: .image, completionHandler: { data, error in
                        if let data,
                           let imageObj = UIImage(data: data) {
                            self.userPastedImageObj = imageObj
                        }
                    })
                }
            }
            .buttonBorderShape(.capsule)

            if let userPastedImageObj {
                Image(uiImage: userPastedImageObj)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

struct PasteButtonSample_Previews: PreviewProvider {
    static var previews: some View {
        PasteButtonSample()
    }
}
