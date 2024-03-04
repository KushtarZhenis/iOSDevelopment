import SwiftUI

struct NewsView: View {
    @EnvironmentObject var data : NewsAPI
    @Environment(\.openURL) var openURL
    
    var body: some View {
        let newsArray = Array(data.news)
        
        return List(newsArray, id: \.self) { news in
            NewsArticle(title: news.title ?? "", urlToImage: news.urlToImage ?? "", author: news.author ?? "", description: news.description ?? "",content: news.content ??  "",urlString: "")
                .onTapGesture {
                    openURL(URL(string: news.url)!)
                }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(NewsAPI())
    }
}
