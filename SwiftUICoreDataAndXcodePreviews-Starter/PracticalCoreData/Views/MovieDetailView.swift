//
//  MovieDetailView.swift
//  MovieDetailView
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

struct MovieDetailView: View {
    
    // The movie whose details we are viewing
    @ObservedObject var movie: Movie
    
    // Whether to show the edit sheet
    @State private var showEditSheet = false
    
    var body: some View {
        Text(movie.name)
            .navigationTitle("Detail")
            .sheet(isPresented: $showEditSheet) {
                NavigationView {
                    MovieEditView(dismissView: $showEditSheet, movie: movie)
                }
            }
            .toolbar {
                
                Button(action: {
                    showEditSheet = true
                }) {
                    Text("Edit")
                }
                
            }
        
    }
    
}

struct MovieDetailView_Previews: PreviewProvider {
    
    // Xcode Previewがロードされると、StorageProviderのpreview staticプロパティを介してサンプルデータがロードされ、再び、環境に挿入されます。
    // MovieDetailViewのロード時には、上記のMovieエクステンションから、詳細を表示するムービーの引数として、static computed property exampleを渡します。
    // サンプルデータはStorageProviderに最初にロードされるので、Movieクラスへの拡張機能でフェッチリクエストの結果を安全に強制アンラップすることができます。
    
    static var previews: some View {
        NavigationView {
            MovieDetailView(movie: Movie.example)
        }
        .environmentObject(StorageProvider.preview)
    }
    
}
