@testable import Whalether
import Foundation

class WeatherWorkerSpy: WeatherWorker {

    var invokedRequestWeather = false
    var invokedRequestWeatherCount = 0
    var invokedRequestWeatherParameters: (request: Weather.GetWeatherReport.Request, completion: (WeatherResult))?
    var invokedRequestWeatherParametersList = [(request: Weather.GetWeatherReport.Request, completion: (WeatherResult))]()
    var stubbedRequestSuccess = true

    override func requestWeather(request: Weather.GetWeatherReport.Request, completion: @escaping (WeatherResult)) {
        invokedRequestWeather = true
        invokedRequestWeatherCount += 1
        invokedRequestWeatherParameters = (request, completion)
        invokedRequestWeatherParametersList.append((request, completion))
        if stubbedRequestSuccess {
            completion(.success(Weather.GetWeatherReport.Response(current: Weather.CurrentWeather(temp: 10, humidity: 10, windSpeed: 10, weather: []), daily: [])))
        } else {
            completion(.failure(Weather.GetWeatherError.cannotDecode(message: "error")))
        }
    }
}
