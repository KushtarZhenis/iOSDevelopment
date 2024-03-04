import SwiftUI
import CachedAsyncImage

struct NewsArticle: View {
    let title: String
    let urlToImage: String
    let author: String
    let description: String
    let content:String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(author)")
                .foregroundColor(.blue)
                .italic()
            
            HStack(alignment: .center) {
                CachedAsyncImage(url: URL(string: urlToImage), transaction: Transaction(animation: .easeInOut)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .transition(.opacity)
                    } else {
                        HStack {
                            Text("There are no Image")
                                .padding()
                        }
                    }
                }
            }
            Text(title)
                .font(.headline)
                .padding(8)
            
            Text(description)
                .lineLimit(6)
                .font(.body)
                .padding(8)
        }
    }
}
struct NewsArticle_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticle(title: "Title", urlToImage: "testurl",author: "nobody", description: "Code Palace",content: "Something wnet wrong")
    }
}
