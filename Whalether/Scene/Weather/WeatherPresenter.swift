import UIKit

protocol WeatherPresentationLogic {
    func presentWeather(response: Weather.GetWeatherReport.Response)
    func presentWeatherFailed(message: String)
}

class WeatherPresenter: WeatherPresentationLogic {
  weak var viewController: WeatherDisplayLogic?
  
    
    func presentWeather(response: Weather.GetWeatherReport.Response) {
        let temp = "\(String(format: "%.1f", response.current.temp))°C"
        let humindity = "\(response.current.humidity) %"
        let windSpeed = "\(response.current.windSpeed) km/h"
        var dailyList: [Weather.ForecastDaily] = []
        
        for (index,daily) in response.daily.enumerated() {
            //if index == 0 { continue }
            let day = convertMiliToDate(daily.dateTime)
            let minTemp = "Minimum: \(String(format: "%.1f", daily.temp.minTemp))°C"
            let maxTemp = "Maximum: \(String(format: "%.1f", daily.temp.maxTemp))°C"
            let daily = Weather.ForecastDaily(day: day, minTemp: minTemp, maxTemp: maxTemp)
            dailyList.append(daily)
        }
        
        let profile: Profile? = UserProfile.shared.profile
        let description: String = "Hello, \(profile?.name ?? profile?.email ?? "") \nWeather : \(response.current.weather.first?.description ?? "")"
        
        let viewModel =  Weather.GetWeatherReport.ViewModel(temp: temp, humidity: humindity, windSpeed: windSpeed, weather: response.current.weather.first?.main ?? "", description: description, daily: dailyList)
        viewController?.displayWeather(viewModel: viewModel)
    }
    
    func presentWeatherFailed(message: String) {
        viewController?.displayWeatherFailed(message: message)
    }
    
    private func convertMiliToDate(_ mili: Int) -> String{
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(mili))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: dateVar)
    }
}



