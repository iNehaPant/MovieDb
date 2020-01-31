
import UIKit

class MoviesViewController: UIViewController {
    
    var movies = [MoviesListViewModel]() // array to hold movies data
    var networkManager: NetworkManager
    var tableView = UITableView()
    var vSpinner: UIView? // loading indicator
    
    lazy var viewModel: MoviesViewModel = {
        return MoviesViewModel()
    }()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initViewModel() {
        viewModel.fetchMoviesFailureClosure = {[weak self] in
            guard let self = self else {return}
            print(self.viewModel.alertMessage)
        }
        
        viewModel.updateLoadingStatusClosure = {[weak self] () in
            guard let self = self else {return}
            if self.viewModel.isLoading {
                self.showSpinner()
            } else {
                self.removeSpinner()
            }
        }
        
        viewModel.reloadTableViewClosure = {[weak self] in
            guard let self = self else {return}
            self.movies = self.viewModel.cellViewModel
            DispatchQueue.main.async {() in
                self.tableView.reloadData()
            }
        }
        
        viewModel.fetchMovies(networkManager)
    }
    
    //MARK: SET UP TABLEVIEW
    fileprivate func setUpTableView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieCell.self, forCellReuseIdentifier: String.init(describing: MovieCell.self))
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: commonSpacing).isActive = true

    }
}

//MARK: TABLEVIEW DATA SOURCE
extension MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieCell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MovieCell.self)) as! MovieCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movies.count > 0 ? 1 : 0
    }
}

//MARK: TABLEVIEW DELEGATE
extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension MoviesViewController {
    //MARK: LOADING INDICATOR
    func showSpinner() {
        let spinnerView = UIView.init(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}


