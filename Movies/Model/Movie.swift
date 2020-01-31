
import Foundation

// MARK: - Movie
struct Movies: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
   /* init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        results = try container.decode(Array.self, forKey: .results)
    }*/
    
}

// MARK: - Result
struct Movie: Codable {
    let popularity: Double?
    let id: Int?
    let voteCount: Int?
    let genreIDS: [Int]?
    
    let video: Bool?
    let voteAverage: Double
    let title, releaseDate, originalLanguage, originalTitle: String?
    let backdropPath: String?
    let adult: Bool?
    let overview, posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity, id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
    }
    
   /* init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        popularity = try container.decode(Double.self, forKey: .popularity)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        id = try container.decode(Int.self, forKey: .id)
        video  = try container.decode(Bool.self, forKey: .video)
        voteAverage  = try container.decode(Double.self, forKey: .voteAverage)

        genreIDS = try container.decode(Array.self, forKey: .genreIDS)

        
        title = try container.decode(String.self, forKey: .title)
        
        
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        adult = try container.decode(Bool.self, forKey: .adult)
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try container.decode(String.self, forKey: .posterPath)
    }*/
}


