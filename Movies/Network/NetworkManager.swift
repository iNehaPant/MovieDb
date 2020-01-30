

import Foundation

class NetworkManager {
    let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
}

enum NetworkError: Error {
    case commonError
    case noMovieError
}
extension NetworkManager: NetworkProtocols {
    //MARK: Fetching movies Info
    /* func fetchMovies(completion: @escaping ([Result], String?) -> Void) {
     let task = URLSession.shared.dataTask(with: baseUrl) {(data, response, error) in
     guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
     completion([], "Error in reponse")
     return
     }
     
     guard let data = data else { return }
     let movie = try? JSONDecoder().decode(Movie.self, from: data)
     completion(movie?.results ?? [],"")
     }
     
     task.resume()
     }*/
    
    func fetchMovies(completion: @escaping (Result <[Movie], NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: baseUrl) {(data, response, error) in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completion(.failure(.commonError))
                return
            }
            
            guard let data = data else { return }
            let movie = try? JSONDecoder().decode(Movies.self, from: data)
            if let movies = movie?.results, movies.count > 0 {
                completion(.success(movies))
            } else {
                completion(.failure(.noMovieError))
            }
        }
        task.resume()
    }
}
