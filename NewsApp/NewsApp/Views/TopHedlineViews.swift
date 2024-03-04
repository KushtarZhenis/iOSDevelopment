import SwiftUI

struct TopHedlineViews: View {
    @StateObject var data = NewsAPI()
    @State private var opac = 0.0
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NewsView()
                    .opacity(opac)
                    .refreshable {
                        data.getData(query: "top-headlines")
                    }
                    .searchable(text: $searchText)
                    .onSubmit {
                        data.getData(query: "top-headlines",searchText: searchText)
                    }
            }
            .environmentObject(data)
            .onAppear {
                data.getData(query:"top-headlines")
            }
            .navigationTitle("Top News")
        }
    }
}
struct TopHedlineViews_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

