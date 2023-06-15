import UIKit

enum Weather {
    
    enum GetWeatherReport {
        struct Request {
            var lat: Double
            var long: Double
        }
        struct Response: Codable {
            var current: CurrentWeather
            var daily: [Daily]
            
            enum CodingKeys: String, CodingKey {
                case current
                case daily
            }
        }
        struct ViewModel {
            var temp: String
            var humidity: String
            var windSpeed: String
            var weather: String
            var description: String
            var daily: [ForecastDaily]
        }
    }
    
    struct CurrentWeather: Codable {
        var temp: Double
        var humidity: Double
        var windSpeed: Double
        var weather: [Weather]
        
        enum CodingKeys: String, CodingKey {
            case temp
            case humidity
            case windSpeed = "wind_speed"
            case weather
        }
    }
    
    struct Weather: Codable {
        var main: String
        var description: String
        
        enum Codingkeys: String, CodingKey {
            case main
            case description
        }
    }
    
    struct ForecastDaily {
        var day: String
        var minTemp: String
        var maxTemp: String
    }
    
    struct Daily: Codable {
        var dateTime: Int
        var temp: DailyTemp
        
        enum CodingKeys: String, CodingKey {
            case dateTime = "dt"
            case temp
        }
    }
    
    struct DailyTemp: Codable {
        var minTemp: Double
        var maxTemp: Double
        
        enum CodingKeys: String, CodingKey {
            case minTemp = "min"
            case maxTemp = "max"
        }
    }
    
    enum GetWeatherError: Error {
      case cannotDecode(message: String)
      case networkFail(message: String)

      var reason: String {
        switch self {
        case let .cannotDecode(message):
          return message
        case let .networkFail(message):
          return message
        }
      }
    }
}
