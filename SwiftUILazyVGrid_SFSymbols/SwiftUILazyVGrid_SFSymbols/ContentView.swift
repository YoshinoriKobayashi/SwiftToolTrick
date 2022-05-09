//
//  ContentView.swift
//  SwiftUILazyVGrid_SFSymbols
//
//  Created by kobayashi on 2022/04/30.
//

import SwiftUI
import SFUserFriendlySymbols

struct ContentView: View {

    @State private var selectedColor = Color.black
    @State private var backgroundColor = Color.white

    var body: some View {

        // グリッド部分
        // LazyGridを使用する為には、GridItemが必要です。
        // repeatingには、GridItem.Sizeを設定します。
        // 今回は特に固定させないので.flexibleに対応するようにしました。
        // countには、今回は垂直方向のグリッドなので、
        // 水平方向のアイテムの個数になります。
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

        //ScrollViewが必要な理由は、LazyVGridだけを記述すると、
        //スクロールすることが出来ず、グリッド内のアイテムが画面以上ある場合は
        //生成することが出来なくなってしまうからです。
        ScrollView {
            // LazyVGrid
            LazyVGrid(columns: columns) {
                //あとは、LazyVGrid内でForEachを使って、SFSymbols.allCasesを
                //呼んであげてCatalogItemを生成します。
                //SFUserFriendlySymbolsのallCasesは、
                //使用しているOSで使用可能な全てのシンボルを返してくれます。
                ForEach(SFSymbols.allCases, id:\.self) {
                    CatalogItem(symbol: $0, color: selectedColor, backgroundColor: backgroundColor)
                }
            }
            .padding(.top)
            .padding(.horizontal)
        }
        .toolbar {
            //背景色を設定できるColorPickerとシンボルの色を設定できる
            //ColorPickerを画面下部のバーに設置しました。
            ToolbarItem(placement: .bottomBar) {
                ColorPicker("背景", selection: $backgroundColor)
            }
            ToolbarItem(placement: .bottomBar) {
                ColorPicker("カラー",selection: $selectedColor)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
