import XCTest
@testable import Movies

class MovieViewControllerTests: XCTestCase {
    
    var controller: MoviesViewController!
    var movies = [Result]()
    var networkManager: NetworkManager!
    
    override func setUp() {
        let url:URL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e600ae42efca88a43a1c4ddaedd275fe&language=en-US&page=1")!
        networkManager = NetworkManager(baseUrl: url)
        controller = MoviesViewController(networkManager: networkManager)
        movies = MovieUtility().getMovieJSON()?.results ?? []
        controller.loadViewIfNeeded()
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
        controller = nil
        networkManager = nil
    }
    
    func test_TableView_Has_Cells_With_Data() {
        let cell: MovieCell = controller.tableView.dequeueReusableCell(withIdentifier: String.init(describing: MovieCell.self)) as! MovieCell
        cell.movie = movies.first
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'Cell'")
        XCTAssertEqual(cell.titleLabel.text, "neha")
        XCTAssertEqual(cell.releaseDateLabel.text, "jgjhgj")

    }
    func test_TableView_Has_Cells_With_No_Data() {
        let cell: MovieCell = controller.tableView.dequeueReusableCell(withIdentifier: String.init(describing: MovieCell.self)) as! MovieCell
        cell.movie = nil
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'Cell'")
        XCTAssertEqual(cell.titleLabel.text, nil)
        XCTAssertEqual(cell.releaseDateLabel.text, nil)
        
    }
    func testTableVieDataSource() {
        XCTAssertNotNil(controller.tableView.dataSource)
    }
    
    func testTableViewDelegate() {
        XCTAssertNotNil(controller.tableView.dataSource)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
