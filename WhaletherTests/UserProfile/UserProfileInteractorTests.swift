@testable import Whalether
import XCTest

class UserProfileInteractorTests: XCTestCase {

    let sut = UserProfileInteractor()
    var workerSpy: UserProfileWorkerSpy!
    var presenterSpy: UserProfilePresentationLogicSpy!
    
    override func setUpWithError() throws {
        workerSpy = UserProfileWorkerSpy()
        presenterSpy = UserProfilePresentationLogicSpy()
        sut.worker = workerSpy
        sut.presenter = presenterSpy
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestUserProfileSuccses() {
        UserProfile.shared.setProfile(uid: "uid", email: "email", name: "name")
        sut.requestUserProfile()
        XCTAssertEqual(presenterSpy.invokedPresentUserProfileCount, 1)
    }
    
    func testRequestUserProfileFailNoUser() {
        UserProfile.shared.clearProfile()
        sut.requestUserProfile()
        XCTAssertEqual(presenterSpy.invokedPresentChangeDisplayNameSuccessCount, 0)
    }
    
    func testRequestChangeDisplayNameSuccess() {
        let mockRequest = UserProfileModel.ChangeDisplayName.Request(displayName: "newName")
        workerSpy.stubbedChangeDisplayNameCompletionResult = (.success(true) , ())
        sut.requestChangeDisplayName(request: mockRequest)
        XCTAssertEqual(presenterSpy.invokedPresentChangeDisplayNameSuccessCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentGeneralErrorCount, 0)
    }
    
    func testRequestChangeDisplayNameFailed() {
        let mockRequest = UserProfileModel.ChangeDisplayName.Request(displayName: "newName")
        workerSpy.stubbedChangeDisplayNameCompletionResult = (.failure(Login.RegisterError.generalError(message: "error")), ())
        sut.requestChangeDisplayName(request: mockRequest)
        XCTAssertEqual(presenterSpy.invokedPresentChangeDisplayNameSuccessCount, 0)
        XCTAssertEqual(presenterSpy.invokedPresentGeneralErrorCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentGeneralErrorParameters?.message, "error")
    }
    
    func testLogout() {
        UserProfile.shared.setProfile(uid: "uid", email: "email", name: "name")
        sut.logout()
        XCTAssertEqual(presenterSpy.invokedPresentLogoutSuccessCount, 1)
        XCTAssertEqual(UserProfile.shared.profile?.email, nil)
        XCTAssertEqual(UserProfile.shared.profile?.name, nil)
        XCTAssertEqual(UserProfile.shared.profile?.uid, nil)
    }
    
}
