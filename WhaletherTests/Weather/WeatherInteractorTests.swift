@testable import Whalether
import XCTest

class WeatherInteractorTests: XCTestCase {
    
    let sut = WeatherInteractor()
    var workerSpy = WeatherWorkerSpy()
    var presenterSpy = WeatherPresentationLogicSpy()
    
    override func setUpWithError() throws {
        workerSpy = WeatherWorkerSpy()
        presenterSpy = WeatherPresentationLogicSpy()
        sut.worker = workerSpy
        sut.presenter = presenterSpy
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequestWeatherSuccess() {
        let request = Weather.GetWeatherReport.Request(lat: 10, long: 10)
        workerSpy.stubbedRequestSuccess = true
        sut.requestWeatherReport(request: request)
        XCTAssertEqual(workerSpy.invokedRequestWeatherCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentWeatherCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentWeatherFailedCount, 0)
    }
    
    func testRequestWeatherFailed() {
        let request = Weather.GetWeatherReport.Request(lat: 10, long: 10)
        workerSpy.stubbedRequestSuccess = false
        sut.requestWeatherReport(request: request)
        XCTAssertEqual(workerSpy.invokedRequestWeatherCount, 1)
        XCTAssertEqual(presenterSpy.invokedPresentWeatherCount, 0)
        XCTAssertEqual(presenterSpy.invokedPresentWeatherFailedCount, 1)
    }
    
    
}
