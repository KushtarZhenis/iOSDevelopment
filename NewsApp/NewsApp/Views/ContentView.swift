import SwiftUI

struct ContentView: View {
  @StateObject var data = NewsAPI()
  @State private var opac = 0.0
  @State private var searchText: String = ""

  var body: some View {
    NavigationView {
      VStack {
        // Assuming NewsView is defined somewhere
        NewsView()
          .opacity(opac)
          .refreshable {
            data.getData(query: "everything")
          }
      }

      .environmentObject(data)
      .onAppear {
        data.getData(query: "everything")

        withAnimation(.easeIn(duration: 2)) {
          opac = 1.0
        }
      }
      .navigationTitle("News")
      .toolbar { // Use toolbar for search bar with custom view
        HStack(spacing: 0) { // Remove spacing between elements
          TextField("Search", text: $searchText, onCommit: {
            data.getData(query: "everything", searchText: searchText)
          })
          .padding(8)
          .background(Color.secondary.colorInvert())
          .cornerRadius(8)
          .frame(maxWidth: .infinity) // Take full width

          Button(action: {
            // Perform search action
            data.getData(query: "everything", searchText: searchText)
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

  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
  }
}
