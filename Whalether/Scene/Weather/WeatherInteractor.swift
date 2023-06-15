import UIKit

protocol WeatherBusinessLogic {
    func requestWeatherReport(request: Weather.GetWeatherReport.Request)
}

protocol WeatherDataStore {
    
}

class WeatherInteractor: WeatherBusinessLogic, WeatherDataStore {
    var presenter: WeatherPresentationLogic?
    var worker: WeatherWorker?
    
    func requestWeatherReport(request: Weather.GetWeatherReport.Request) {
        worker?.requestWeather(request: request, completion: {[weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(response):
                self.presenter?.presentWeather(response: response)
            case let .failure(error):
                self.presenter?.presentWeatherFailed(message: error.reason)
            }
        })
    }
}
