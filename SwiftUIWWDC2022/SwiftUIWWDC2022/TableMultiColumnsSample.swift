//
//  TableMultiColumnsSample.swift
//  SwiftUIWWDC2022
//
//  Created by kobayashi on 2022/06/21.
//

import SwiftUI

struct TableMultiColumnsSample: View {

    struct MyPokemonFriend: Identifiable {
        var id = UUID()
        var name: String
        var species: String
        var status: String
    }
    static let demoData: [MyPokemonFriend] = [
        .init(name: "Pika", species: "Pikachu", status: "Sleeping"),
        .init(name: "Zero", species: "Zeraora", status: "Charing my phone"),
        .init(name: "Luca", species: "Lucario", status: "Hiking")
    ]


    var body: some View {
        Table(TableMultiColumnsSample.demoData) {
            TableColumn("Name", value: \.name)
            TableColumn("Species", value: \.species)
            TableColumn("Status", value: \.status)
        }
    }
}

struct TableMultiColumnsSample_Previews: PreviewProvider {
    static var previews: some View {
        TableMultiColumnsSample()
    }
}
