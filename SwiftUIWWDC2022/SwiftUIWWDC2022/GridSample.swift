//
//  GridSample.swift
//  SwiftUIWWDC2022
//
//  Created by kobayashi on 2022/06/22.
//

import SwiftUI

struct GridSample: View {
    var body: some View {
        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
            GridRow {
                RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
                    .gridCellColumns(2) // これは、このビュー要素が2つのセルカラムとして扱われることを意味します。
            }
            GridRow {
                RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
                RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)

            }
        }
    }
}

struct GridSample_Previews: PreviewProvider {
    static var previews: some View {
        GridSample()
    }
}
