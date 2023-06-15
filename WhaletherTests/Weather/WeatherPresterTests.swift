@testable import Whalether
import XCTest

class WeatherPresterTests: XCTestCase {
    
    let sut = WeatherPresenter()
    var viewControllerSpy: WeatherDisplayLogicSpy!
    
    override func setUpWithError() throws {
        viewControllerSpy = WeatherDisplayLogicSpy()
        sut.viewController = viewControllerSpy
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPresentWeatherShouldPassCorrectData() {
        let mockResponse = Weather.GetWeatherReport.Response(current: Weather.CurrentWeather(temp: 10, humidity: 10, windSpeed: 10, weather: [Weather.Weather(main: "cloud", description: "shatter clound")]), daily: [Weather.Daily(dateTime: 1686805200, temp: Weather.DailyTemp(minTemp: 10, maxTemp: 10))])
        sut.presentWeather(response: mockResponse)
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherFailedCount, 0)
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherParameters!.viewModel.temp, "10.0°C")
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherParameters!.viewModel.humidity, "10.0 %")
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherParameters!.viewModel.windSpeed, "10.0 km/h")
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherParameters!.viewModel.weather, "cloud")
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherParameters!.viewModel.daily.count, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherParameters!.viewModel.daily.first?.day, "Fri")
    }
    
    func testWeatherFailed() {
        sut.presentWeatherFailed(message: "error")
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherCount, 0)
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherFailedCount, 1)
        XCTAssertEqual(viewControllerSpy.invokedDisplayWeatherFailedParameters?.message, "error")
    }
}
