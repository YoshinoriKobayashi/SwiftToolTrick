//
//  NavigationStackSample.swift
//  SwiftUIWWDC2022
//
//  Created by kobayashi on 2022/06/22.
//

import SwiftUI

struct NavigationStackSample: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(pokemonObjs) { pokemon in
                    NavigationLink(pokemon.name, value: pokemon)
                }
            }
        }
    }
}

struct NavigationStackSample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackSample()
    }
}
