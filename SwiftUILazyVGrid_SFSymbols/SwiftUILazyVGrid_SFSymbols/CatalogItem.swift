//
//  CatalogItem.swift
//  SwiftUILazyVGrid_SFSymbols
//
//  Created by kobayashi on 2022/05/09.
//

import SwiftUI
import SFUserFriendlySymbols

struct CatalogItem: View {

    private let symbol: SFSymbols
    private let color: Color
    private let backgroundColor: Color
    private let baseLength: CGFloat
    private let imageWidth: CGFloat

    init(symbol: SFSymbols, color: Color, backgroundColor: Color) {

        self.symbol = symbol
        self.color = color
        self.backgroundColor = backgroundColor

        // 今回はUIScreen.main.bounds.width * 0.25したものを基準の長さにしており、
        // imageWidthはその基準の長さの半分の値にしています。
        baseLength = UIScreen.main.bounds.width * 0.25
        imageWidth = baseLength * 0.5

    }

    var body: some View {
        VStack(alignment: .center) {
            // シンボルイメージ部分
            ZStack {

                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 0.5)
                Image(symbol: symbol)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth)
                    .foregroundColor(color)
            }
            .frame(width: baseLength, height: baseLength)
            // シンボルネーム部分
            // シンボルネームが中心にきて、尚且つサイドにスペースが
            // 出来て欲しかったのでHStack内でTextを
            // 記述して両サイドにSpacer()を配置しています。
            HStack {
                Spacer()
                Text(symbol.rawValue)
                    .frame(height: 35, alignment: .top)
                    .multilineTextAlignment(.center)
                    .font(.caption)
                Spacer()
            }
        }
    }
}

struct CatalogItem_Previews: PreviewProvider {
    static var previews: some View {
        CatalogItem(symbol: ._00Circle, color: .black, backgroundColor: .white)
    }
}
