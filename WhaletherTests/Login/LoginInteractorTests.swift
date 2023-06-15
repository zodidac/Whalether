@testable import Whalether
import XCTest

class LoginInteractorTests: XCTestCase {
    let sut = LoginInteractor()
    var workerSpy: LoginWorkerSpy!
    var presenterSpy: LoginPresentationLogicSpy!
    
    override func setUpWithError() throws {
        workerSpy = LoginWorkerSpy()
        presenterSpy = LoginPresentationLogicSpy()
        sut.worker = workerSpy
        sut.presenter = presenterSpy
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestLoginSuccess() {
        let mockRequest = Login.Login.Request(email: "email", password: "password")
        workerSpy.stubbedRequestLoginSuccess = true
        sut.requestLogin(request: mockRequest)
        XCTAssertEqual(workerSpy.invokedRequestLoginCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentLoginSuccessCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentLoginFailedCount, 0)
    }
    
    func testRequestLoginFailed() {
        let mockRequest = Login.Login.Request(email: "email", password: "password")
        workerSpy.stubbedRequestLoginSuccess = false
        sut.requestLogin(request: mockRequest)
        XCTAssertEqual(workerSpy.invokedRequestLoginCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentLoginSuccessCount, 0)
        XCTAssertEqual(presenterSpy.invokedPresentLoginFailedCount, 1)
    }
    
    
}
