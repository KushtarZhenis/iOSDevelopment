import SwiftUI

@main
struct NewsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                    content:  {
                ContentView().tabItem {
                    Image(systemName: "newspaper")
                    Text("Everything")
                        .font(.title)
                }.tag(1)
                TopHedlineViews().tabItem { 
                    Image(systemName: "flame.circle.fill")
                    Text("Top Headlines")
                        .font(.title)
                }.tag(2)
            })
        }
    }
}
