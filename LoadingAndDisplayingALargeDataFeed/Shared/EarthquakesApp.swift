/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The app and main window group scene.
*/

import SwiftUI

@main
struct EarthquakesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // 環境変数：managedObjectContextに、QuakesProvider.shared.container.viewContextを設定
                .environment(\.managedObjectContext, QuakesProvider.shared.container.viewContext)
        }
    }
}
