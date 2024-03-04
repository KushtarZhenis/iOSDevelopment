import SwiftUI

struct TopHedlineViews: View {
    @StateObject var data = NewsAPI()
    @State private var opac = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                NewsView()
                    .opacity(opac)
                    .refreshable {
                        data.getData(query: "top-headlines")
                    }
            }
            .environmentObject(data)
            .onAppear {
                data.getData(query:"top-headlines")
                
                withAnimation(.easeIn(duration: 2)) {
                    opac = 1.0
                }
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

