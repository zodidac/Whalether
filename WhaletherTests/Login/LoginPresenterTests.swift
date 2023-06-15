@testable import Whalether
import XCTest

class LoginPresenterTests: XCTestCase {
    let sut = LoginPresenter()
    var viewControllerSpy: LoginDisplayLogicSpy!
    
    override func setUpWithError() throws {
        viewControllerSpy = LoginDisplayLogicSpy()
        sut.viewController = viewControllerSpy
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPresentLoginSuccess() {
        sut.presentLoginSuccess()
        XCTAssertEqual(viewControllerSpy.invokedDisplayLoginSuccessCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayLoginFailedCount, 0)
    }
    
    func testPresentLoginFailed() {
        sut.presentLoginFailed(message: "error")
        XCTAssertEqual(viewControllerSpy.invokedDisplayLoginSuccessCount, 0)
        XCTAssertEqual(viewControllerSpy.invokedDisplayLoginFailedCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayLoginFailedParameters?.message, "error")
    }
}
