
import UIKit

class MoviesViewController: UIViewController {
    
    var movies = [Result]() // array to hold movies data
    var networkManager: NetworkManager
    var tableView = UITableView()
    var vSpinner: UIView? // loading indicator
    
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
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    //MARK: NETWORK FETCH MOVIES
    func fetchMovies() {
        showSpinner(onView: self.view)
        self.networkManager.fetchMovies {[weak self] (movies, errorMessage) in
            guard let self = self else {return}
            self.removeSpinner()
            if movies.count > 0 {
                self.movies = movies
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    self.tableView.reloadData()
                }
            }
        }
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
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
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


