import SwiftUI
import CachedAsyncImage

struct NewsArticle: View {
    let title: String
    let urlToImage: String
    let author: String
    let description: String
    let content:String
    @State private var image: UIImage? = nil
            let urlString: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(author)")
                .foregroundColor(.black)
                .bold()
                .frame(alignment: .center)
            HStack(alignment: .center) {
                CachedAsyncImage(url: URL(string: urlToImage), transaction: Transaction(animation: .easeInOut)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .transition(.opacity)
                    }else if(urlToImage.isEmpty){
                      
                    } else {
                        HStack {
                            
                            Color.gray
                        
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .transition(.opacity)
                                                .opacity(0.5)
                                                .edgesIgnoringSafeArea(.all)
                            
                                .onAppear(perform: loadImage)
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
    func loadImage() {
           if let cachedImage = ImageCache.shared.image(forKey: urlString) {
               self.image = cachedImage
               return
           }
           guard let url = URL(string: urlString) else { return }
           URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else {
                   print("Failed to load image:", error ?? "Unknown error")
                   return
               }
               if let downloadedImage = UIImage(data: data) {
                   DispatchQueue.main.async {
                       self.image = downloadedImage
                       ImageCache.shared.saveImage(downloadedImage, forKey: urlString)
                   }
               }
           }.resume()
       }
}


struct NewsArticle_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticle(title: "Title", urlToImage: "testurl",author: "nobody", description: "Code Palace",content: "Something wnet wrong",urlString: "")
    }
}
class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}

