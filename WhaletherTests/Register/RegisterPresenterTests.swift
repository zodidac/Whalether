@testable import Whalether
import XCTest

class RegisterPresenterTests: XCTestCase {
    let sut = RegisterPresenter()
    var viewControllerSpy: RegisterDisplayLogicSpy!
    
    override func setUpWithError() throws {
        viewControllerSpy = RegisterDisplayLogicSpy()
        sut.viewController = viewControllerSpy
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresentRegisterSuccess() {
        sut.presentRegisterSuccess()
        XCTAssertEqual(viewControllerSpy.invokedDisplayRegisterSuccessCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayRegisterInfoFailedCount, 0)
    }
    
    func testPresenterRegisterFailed() {
        sut.presentRegisterInfoFailed(message: "error")
        XCTAssertEqual(viewControllerSpy.invokedDisplayRegisterSuccessCount, 0)
        XCTAssertEqual(viewControllerSpy.invokedDisplayRegisterInfoFailedCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayRegisterInfoFailedParameters?.message, "error")
    }
}
