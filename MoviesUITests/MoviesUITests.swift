
import XCTest

class MoviesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let tablesQuery = XCUIApplication().tables
        let cell = tablesQuery.staticTexts["17 September 2019"]
        XCTAssertNotNil(cell)
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["15 January 2020"]/*[[".cells.staticTexts[\"15 January 2020\"]",".staticTexts[\"15 January 2020\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["10 December 2019"]/*[[".cells.staticTexts[\"10 December 2019\"]",".staticTexts[\"10 December 2019\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //let cellAtIndex1 = tablesQuery.ele
    }

}
