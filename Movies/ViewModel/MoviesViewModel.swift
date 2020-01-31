

import Foundation


class MoviesViewModel {
    
    var fetchMoviesFailureClosure: (() -> Void)?
    var updateLoadingStatusClosure: (() -> Void)?
    var reloadTableViewClosure:(() -> Void)?
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingStatusClosure?()
        }
    }
    
    var alertMessage: String = "Its an Error" {
        didSet {
            fetchMoviesFailureClosure?()
        }
    }
    
    var cellViewModel: [MoviesListViewModel] = [MoviesListViewModel]() {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    func fetchMovies(_ newtorkManager: NetworkManager) {
        self.isLoading = true
        newtorkManager.fetchMovies {[weak self] result in
            guard let self = self else {return}
            self.isLoading = false
            switch result {
            case .failure(let error):
                self.getErrorMessage(error: error)
            case .success(let movies):
                self.processMoviesData(movies: movies)
            }
        }
    }
    
    func getErrorMessage(error: NetworkError) {
        switch error {
        case .commonError:
            alertMessage =  "Something went wrong"
        default:
            alertMessage = "Error"
        }
    }
    
    func processMoviesData(movies: [Movie]) {
        var mVM = [MoviesListViewModel]()
        for movie in movies {
            mVM.append(createMovieVM(movie: movie))
        }
        cellViewModel = mVM
    }
    
    func createMovieVM(movie: Movie) -> MoviesListViewModel {
        var rDate: String?
        if let releaseDate = movie.releaseDate {
            if let reDate = releaseDate.toDate() {
                rDate = reDate.toString()
            }
        }
        return MoviesListViewModel(imageUrl: movie.posterPath ?? "",
                                   titleTextLbl: movie.title ?? "",
                                   releaseDateTextLbl: rDate ?? "" ,
                                   votingAvgLbl: String(movie.voteAverage * 10))
    }
}

struct MoviesListViewModel {
    let imageUrl: String
    let titleTextLbl: String
    let releaseDateTextLbl: String
    let votingAvgLbl: String
}
