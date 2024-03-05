import SwiftUI

struct ContentView: View {
    @StateObject var data = NewsAPI()
    @State private var opac = 0.0
    @State private var searchQuery = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Search...", text: $searchQuery)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(9)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(white: 0.9, opacity: 0.7)
                                        , lineWidth: 1)
                        )
                    Button(action: {
                        data.getData(type: "everything", query: searchQuery)
                    }){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                            .padding(12)
                            .background(colorScheme == .dark
                                        ? Color.gray
                                        : Color(white: 0.9, opacity: 0.7))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(colorScheme == .dark
                                            ? Color.black
                                            : Color.white, lineWidth: 1))
                            .frame(alignment: .center)
                    }
                }
                .padding(18)
                
                NewsView()
                    .opacity(opac)
            }
            .refreshable {
                data.getData(type: "everything", query: searchQuery)
            }
            .environmentObject(data)
            .onAppear {
                data.getData(type: "everything", query: searchQuery)
                withAnimation(.easeIn(duration: 1)) {
                    opac = 1.0
                }
            }
            .navigationTitle("News")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

