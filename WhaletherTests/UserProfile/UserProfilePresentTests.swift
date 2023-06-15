@testable import Whalether
import XCTest

class UserProfilePresentTests: XCTestCase {
    
    let sut = UserProfilePresenter()
    var viewControllerSpy: UserProfileDisplayLogicSpy!

    
    override func setUpWithError() throws {
        viewControllerSpy = UserProfileDisplayLogicSpy()
        sut.viewController = viewControllerSpy
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresentUserProfile() {
        let mockResponse = UserProfileModel.Profile.Response(email: "email", displayName: "displayName")
        sut.presentUserProfile(response: mockResponse)
        XCTAssertEqual(viewControllerSpy.invokedDisplayUserProfileCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayGeneralErrorCount, 0)
    }
    
    func testPresentChangeDisplayNameSuccess() {
        sut.presentChangeDisplayNameSuccess()
        XCTAssertEqual(viewControllerSpy.invokedDisplayChangeDisplayNameSuccessCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayGeneralErrorCount, 0)
    }
    
    func testPresentLogoutSuccess() {
        sut.presentLogoutSuccess()
        XCTAssertEqual(viewControllerSpy.invokedDisplayLogoutSuccessCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayGeneralErrorCount, 0)
    }
    
    func testPresentGeneralError() {
        sut.presentGeneralError(message: "error")
        XCTAssertEqual(viewControllerSpy.invokedDisplayGeneralErrorCount, 1)
    }
}
