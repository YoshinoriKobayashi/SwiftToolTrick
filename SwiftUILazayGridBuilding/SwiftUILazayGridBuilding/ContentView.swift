//
//  ContentView.swift
//  SwiftUILazayGridBuilding
//
//  Created by kobayashi on 2022/05/10.
//

import SwiftUI

struct ContentView: View {

    // データ
    private var symbols = ["sun.max", "moon.fill", "sparkles", "cloud", "cloud.drizzle", "cloud.fog", "cloud.snow.fill", "cloud.sun", "snowflake.circle", "tornado"]
    private var colors: [Color] = [.orange, .blue, .pink]

    //GridItemインスタンスは、LazyHGridやLazyVGridビューの
    //アイテムのレイアウトを設定するために使用する
    //GridItemが3つあるのは、3カラムのレイアウト
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    // Arrayで書いても同じ
    // private var gridItemLayout: [GridItem] =
    // Array(repeating: .init(.flexible()), count: 3)

    //.flexible
    //6列のグリッドを記述したい場合は、このようにGridItemの配列を作成します
//    private var gridItemLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 6)

    //.flexible()は、グリッドレイアウトを制御する
    //ためのサイズタイプの1つに過ぎません。
    //できるだけ多くのアイテムを一列に並べたい場合は、
    //このように適応的なサイズタイプを使用することができます。

    //.adaptive
    //アダプティブサイズタイプでは、アイテムの最小サイズを指定する必要があります。
    //下のコードでは、各グリッドのアイテムの最小サイズは 40 です
//    private var gridItemLayout = [GridItem(.adaptive(minimum: 40))]

    //.adaptive(minimum: 50)を使うことで、LazyVGridは各項目の最小サイズが
    //50ポイントになるように、できるだけ多くの画像を一列に並べるよう指示。

    //.fixed
    //固定幅のカラムを作成
    //画像を2列にレイアウトして、1列目の幅が100ポイント、
    //2列目の幅が150ポイントになるようにしたい場合
    // private var gridItemLayout = [GridItem(.fixed(100)), GridItem(.fixed(150))]

    //より複雑なレイアウト
    //固定サイズのGridItemと、それに続く適応的なサイズのGridItemの指定
//    private var gridItemLayout = [GridItem(.fixed(150)), GridItem(.adaptive(minimum: 0, maximum: 50))]
    //LazyVGridは150ポイント幅の固定サイズのカラムを作成。
    //そして、残りのスペースにできるだけ多くの項目を埋めようとします。


var body: some View {
    ScrollView{
//            LazyVGrid:縦方向
//            columns：カラム
//            spacing：行間
        LazyVGrid(columns: gridItemLayout,spacing: 20) {
            ForEach(0...999, id: \.self) {
                //$0には0...999のインデクス番号が入っている
                let _ = print("$0:\($0)")
                let _ = print("symbols.count:\(symbols.count)")
                let _ = print("$0 % symbols.count:\($0 % symbols.count)")
                //%剰余を使うことで順番に
                Image(systemName: symbols[$0 % symbols.count])
                    .font(.system(size: 30))
//                        .frame(width: 50, height: 50)
                    //画像の幅がカラム幅いっぱいになるようにする
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                    .background(colors[$0 % colors.count])
                    .cornerRadius(10)
//                    .onTapGesture {
//                        print("タップされた")
//                    }
            }
        }
    }

//        //横長のグリッド
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: gridItemLayout, spacing: 20) {
//                ForEach((0...9999), id: \.self) {
//                    Image(systemName: symbols[$0 % symbols.count])
//                        .font(.system(size: 30))
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50,maxHeight: .infinity)
//                        .background(colors[$0 % colors.count])
//                        .cornerRadius(10)
//                }
//            }
//        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
