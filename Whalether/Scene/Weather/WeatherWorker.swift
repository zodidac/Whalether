import UIKit
import Moya

typealias WeatherResult = (Result<Weather.GetWeatherReport.Response, Weather.GetWeatherError>) -> Void

class WeatherWorker {
    func requestWeather(request: Weather.GetWeatherReport.Request, completion: @escaping (WeatherResult)) {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        let provider = MoyaProvider<WeatherAPI>(plugins: [networkLogger])
        let weatherAPI = WeatherAPI.fetchWeather(lat: request.lat, long: request.long)
        provider.request(weatherAPI) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try JSONDecoder().decode(Weather.GetWeatherReport.Response.self,from: response.data)
                    completion(.success(response))
                } catch {
                    completion(.failure(Weather.GetWeatherError.cannotDecode(message: "เกิดข้อผิดพลาดกรุณาลองใหม่อีกครั้ง")))
                    break
                }
            case let .failure(error):
                completion(.failure(Weather.GetWeatherError.networkFail(message: "เกิดข้อผิดพลาดกรุณาลองใหม่อีกครั้ง")))
                break
            }
        }
    }
}



