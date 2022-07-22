//
//  Movie+PreviewProvider.swift
//  PracticalCoreData
//
//  Created by Swift-Beginners on 2022/07/22.
//

import CoreData
import Foundation

// MovieDetailView、MovieEditViewで使用するムービーを提供するために存在する。
extension Movie {
    
    // Xcodeプレビュー用サンプルムービー
    static var example: Movie {
        
        // Get the first movie from the in-memory Core Data store
        let context = StorageProvider.preview.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        // その静的な計算プロパティの最後の行で強制的にアンラップされているオプションは、あなたをためらわせるかもしれません。
        return (results?.first!)!
    }
    
}
