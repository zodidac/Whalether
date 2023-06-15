@testable import Whalether
import XCTest

class RegisterInteractorTests: XCTestCase {
    let sut = RegisterInteractor()
    var workerSpy:RegisterWorkerSpy!
    var presenterSpy:RegisterPresentationLogicSpy!
    
    override func setUpWithError() throws {
        workerSpy = RegisterWorkerSpy()
        presenterSpy = RegisterPresentationLogicSpy()
        sut.worker = workerSpy
        sut.presenter = presenterSpy
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testValidateRegisterSuccess() {
        let mockRequest = Register.Registration.Request(email: "email", password: "password", rePasswrd: "password")
        workerSpy.stubbedRegisterSuccess = true
        sut.validateRegisterInfo(request: mockRequest)
        XCTAssertEqual(workerSpy.invokedRegisterWithFirebaseCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentRegisterSuccessCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentRegisterInfoFailedCount, 0)
    }
    
    func testValidateRegisterFailed() {
        let mockRequest = Register.Registration.Request(email: "email", password: "password", rePasswrd: "password2")
        sut.validateRegisterInfo(request: mockRequest)
        XCTAssertEqual(workerSpy.invokedRegisterWithFirebaseCount, 0)
        XCTAssertEqual(presenterSpy.invokedPresentRegisterSuccessCount, 0)
        XCTAssertEqual(presenterSpy.invokedPresentRegisterInfoFailedCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentRegisterInfoFailedParameters?.message, "Password didn't match")
    }
    
    func testRegisterFailedWithAPI() {
        let mockRequest = Register.Registration.Request(email: "email", password: "password", rePasswrd: "password")
        workerSpy.stubbedRegisterSuccess = false
        sut.validateRegisterInfo(request: mockRequest)
        XCTAssertEqual(workerSpy.invokedRegisterWithFirebaseCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentRegisterSuccessCount, 0)
        XCTAssertEqual(presenterSpy.invokedPresentRegisterInfoFailedCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentRegisterInfoFailedParameters?.message, "error")
    }
    

}
