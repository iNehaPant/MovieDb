import XCTest
@testable import Movies

class RepositoryViewControllerTests: XCTestCase {
    
    var controller: MoviesViewController!
    var tableView: UITableView!
    var delegate: UITableViewDelegate!
    var movies = [Result]()
    var networkManager: NetworkManager!
    
    override func setUp() {
        let url:URL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e600ae42efca88a43a1c4ddaedd275fe&language=en-US&page=1")!
        networkManager = NetworkManager(baseUrl: url)
        controller = MoviesViewController(networkManager: networkManager)
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        delegate = tableView.delegate
    }
    
    func testMovieData() {
        let expect = XCTestExpectation(description: "callback")
        self.networkManager.fetchMovies { (result, error) in
            if result.count > 0 {
                expect.fulfill()
                XCTAssertNotNil(result)
                for data in result {
                    XCTAssertNotNil(data.id)
                }
            }
        }
        wait(for: [expect], timeout: 6)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableViewHasCells() {
        let cell:MovieCell = controller.tableView.dequeueReusableCell(withIdentifier: String.init(describing: MovieCell.self)) as! MovieCell
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'Cell'")
    }
    
    
    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === controller,
                      "Controller should be delegate for the table view")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
