@testable import Whalether

import Foundation

class WeatherDisplayLogicSpy: WeatherDisplayLogic {

    var invokedDisplayWeather = false
    var invokedDisplayWeatherCount = 0
    var invokedDisplayWeatherParameters: (viewModel: Weather.GetWeatherReport.ViewModel, Void)?
    var invokedDisplayWeatherParametersList = [(viewModel: Weather.GetWeatherReport.ViewModel, Void)]()

    func displayWeather(viewModel: Weather.GetWeatherReport.ViewModel) {
        invokedDisplayWeather = true
        invokedDisplayWeatherCount += 1
        invokedDisplayWeatherParameters = (viewModel, ())
        invokedDisplayWeatherParametersList.append((viewModel, ()))
    }

    var invokedDisplayWeatherFailed = false
    var invokedDisplayWeatherFailedCount = 0
    var invokedDisplayWeatherFailedParameters: (message: String, Void)?
    var invokedDisplayWeatherFailedParametersList = [(message: String, Void)]()

    func displayWeatherFailed(message: String) {
        invokedDisplayWeatherFailed = true
        invokedDisplayWeatherFailedCount += 1
        invokedDisplayWeatherFailedParameters = (message, ())
        invokedDisplayWeatherFailedParametersList.append((message, ()))
    }
}
