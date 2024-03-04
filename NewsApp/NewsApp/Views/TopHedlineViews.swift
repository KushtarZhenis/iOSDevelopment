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
            }
            
            .environmentObject(data)
            .onAppear {
                data.getData(query:"top-headlines")
                withAnimation(.easeIn(duration: 2)) {
                    opac = 1.0
                }
            }
            .navigationTitle("Top News")
            .toolbar {
                HStack(spacing: 0) {
                    TextField("Search", text: $searchText, onCommit: {
                        data.getData(query: "top-headlines", searchText: searchText)
                    })
                    .padding(8)
                    .background(Color.secondary.colorInvert())
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        data.getData(query: "top-headlines", searchText: searchText)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(Color.secondary.colorInvert())
                            .cornerRadius(8)
                            .frame(alignment: .center)
                    }
                }
            }
            
        }
    }
    
    struct TopHedlineViews_Previews: PreviewProvider {
        static var previews: some View {
            TopHedlineViews()
        }
    }
}
