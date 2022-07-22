//
//  StorageProvider.swift
//  StorageProvider
//
//  Created by Russell Gordon on 2021-07-16.
//

import CoreData
import Foundation

// Must conform to ObservableObject to be passed through the environment
class StorageProvider: ObservableObject {
    
    // For showing the list of movies
    @Published private(set) var movies: [Movie] = []
    
    // For initializing the Core Data stack and loading the Core Data model file
    let persistentContainer: NSPersistentContainer
    
    // For use with Xcode Previews, provides some data to work with for examples
    static var preview: StorageProvider = {
        
        // メモリのみで動作するプロバイダのインスタンスを作成する
        // true:メモリのみで動作するプロバイダのインスタンスを作成する、Xcode Previewsを実行すると、MovieListViewには、繰り返しのない、最初のムービーのリストだけが表示されるはずです。
        // 
        let storageProvider = StorageProvider(inMemory: false)
        
        // Add a few test movies
        let titles = [
            "The Godfather",
            "The Shawshank Redemption", 
            "Schindler's List", 
            "Raging Bull", 
            "Casablanca", 
            "Citizen Kane",
        ]
        
        for title in titles {
            storageProvider.saveMovie(named: title)
        }
        
        // Now save these movies in the Core Data store
        do {
            try storageProvider.persistentContainer.viewContext.save()
        } catch {
            // Something went wrong 😭
            print("Failed to save test movies: \(error)")
        }
        
        return storageProvider
    }()
    
    // 新しく導入されたパラメータにデフォルト値を提供することで、既存のコールサイトを更新する必要がありません。アプリがプレビューの外で実行されているとき、Core Dataストアへの変更を持続させたいので、デフォルト値のfalseは論理的です。
    init(inMemory: Bool = false) {
        
        // Access the model file
        // イニシャライザーの中で最初に起こることは、NSPersistentContainer のインスタンスが作成されることであることに注意してください。
        persistentContainer = NSPersistentContainer(name: "PracticalCoreData")
        
        // Don't save information for future use if running in memory...
        //        ここで行った編集により、StorageProviderのインスタンスを作成し、そのデータを変更しても、長期記憶媒体に書き込まれるのではなく、メモリ内にのみ保持されるため、永続化されないようにすることができます。
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        // Attempt to load persistent stores (the underlying storage of data)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                
                // For now, any failure to load the model is a programming error, and not recoverable
                fatalError("Core Data store failed to load with error: \(error)")
            } else {
                
                print("Successfully loaded persistent stores.")
                
                // Get all the movies
                self.movies = self.getAllMovies()
            }
            
        }
    }
    
}

// Save a movie
extension StorageProvider {
    
    func saveMovie(named name: String) {
        
        // New Movie instance is tied to the managed object context
        let movie = Movie(context: persistentContainer.viewContext)
        
        // Set the name for the new movie
        movie.name = name
        
        do {
            
            // Persist the data in this managed object context to the underlying store
            try persistentContainer.viewContext.save()
            
            print("Movie saved successfully")
            
            // Refresh the list of movies
            movies = getAllMovies()
            
        } catch {
            
            // Something went wrong 😭
            print("Failed to save movie: \(error)")
            
            // Rollback any changes in the managed object context
            persistentContainer.viewContext.rollback()
            
        }
        
    }
    
}

// Delete a movie
extension StorageProvider {
    
    func deleteMovies(at offsets: IndexSet) {
        for offset in offsets {
            let movieToDelete = movies[offset]
            deleteMovie(movieToDelete)
        }
    }
    
    func deleteMovie( _ movie: Movie) {
        
        persistentContainer.viewContext.delete(movie)
        
        do {
            
            try persistentContainer.viewContext.save()
            
            print("Movie deleted.")
            
            // Refresh the list of movies
            movies = getAllMovies()
            
        } catch {
            
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
            
        }
        
    }
    
}

// Update a movie
extension StorageProvider {
    
    func updateMovies() {
        
        do {
            // Tell SwiftUI that the list of movies is being modified
            objectWillChange.send()
            
            // Actually persist/save the changes to the managed object context
            try persistentContainer.viewContext.save()
            print("Movie updated.")
            
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
        
    }
    
}

// Get all the movies
extension StorageProvider {
    
    // Made private because views will access the movies retrieved from Core Data via the movies array in StorageProvider
    private func getAllMovies() -> [Movie] {
        
        // Must specify the type with annotation, otherwise Xcode won't know what overload of fetchRequest() to use (we want to use the one for the Movie entity)
        // The generic argument <Movie> allows Swift to know what kind of managed object a fetch request returns, which will make it easier to return the list of movies as an array
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            
            // Return an array of Movie objects, retrieved from the Core Data store
            return try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch {
            
            print("Failed to fetch movies \(error)")
            
        }
        
        // If an error occured, return nothing
        return []
    }
    
}
