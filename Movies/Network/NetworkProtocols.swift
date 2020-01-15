
import Foundation

protocol NetworkProtocols {
    //MARK: Fetching movies Info
    //Result is the collection of Movies
    func fetchMovies(completion: @escaping ([Result], String?) -> Void)
}
