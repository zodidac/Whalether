@testable import Whalether
import Foundation

class WeatherPresentationLogicSpy: WeatherPresentationLogic {

    var invokedPresentWeather = false
    var invokedPresentWeatherCount = 0
    var invokedPresentWeatherParameters: (response: Weather.GetWeatherReport.Response, Void)?
    var invokedPresentWeatherParametersList = [(response: Weather.GetWeatherReport.Response, Void)]()

    func presentWeather(response: Weather.GetWeatherReport.Response) {
        invokedPresentWeather = true
        invokedPresentWeatherCount += 1
        invokedPresentWeatherParameters = (response, ())
        invokedPresentWeatherParametersList.append((response, ()))
    }

    var invokedPresentWeatherFailed = false
    var invokedPresentWeatherFailedCount = 0
    var invokedPresentWeatherFailedParameters: (message: String, Void)?
    var invokedPresentWeatherFailedParametersList = [(message: String, Void)]()

    func presentWeatherFailed(message: String) {
        invokedPresentWeatherFailed = true
        invokedPresentWeatherFailedCount += 1
        invokedPresentWeatherFailedParameters = (message, ())
        invokedPresentWeatherFailedParametersList.append((message, ()))
    }
}
