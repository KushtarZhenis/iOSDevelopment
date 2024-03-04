import Foundation

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Codable, Hashable{
    let id: UUID?
    let title: String?
    let urlToImage: String?
    let author: String?
    let description: String?
    let url: String
    let publishedAt: String?
    let content: String?

    init(title: String, urlToImage: String, author: String, description: String, url: String, publishedAt: String, content: String) {
        self.id = UUID()
        self.title = title
        self.urlToImage = urlToImage
        self.author = author
        self.description = description
        self.url = url
        self.publishedAt = publishedAt
        self.content = content
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct Source: Codable {
    let id: String?
    let name: String
}
class NewsAPI: ObservableObject {
    @Published var news: [Article] = []
    
    private var query: String = "everything"
    private var searchText: String = "apple"
    
    func fetchData(query: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let apiKey = "c9a8624707bc4d8199723dc52b50ada6"
        let urlString = "https://newsapi.org/v2/\(query)?q=\(searchText)&apiKey=\(apiKey)"
        
        guard let apiUrl = URL(string: urlString) else {
            let error = NSError(domain: "InvalidURL", code: -1, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: apiUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "HTTPError", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard let jsonData = data else {
                let error = NSError(domain: "DataError", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
                completion(.success(jsonData))
        }
        
        task.resume()
    }
    

    func getData(query: String, searchText: String? = nil) {
        self.query = query
        self.searchText = searchText ?? "apple"
        
        fetchData(query: query) { result in
            switch result {
            case .success(let jsonData):
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(NewsResponse.self, from: jsonData)
                    
                    DispatchQueue.main.async { // Update on the main thread
                        self.news = newsResponse.articles
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

}
        
