import Moya

public enum WeatherAPI {
    case fetchWeather(lat: Double, long: Double)
}

extension WeatherAPI: TargetType {
    
    public var base: String {
        "https://api.openweathermap.org"
    }
    
    public var baseURL: URL { URL(string: base)! }
    
    public var path: String {
        switch self {
        case .fetchWeather:
            return "/data/3.0/onecall"
        }
    }
    

    
    public var method: Moya.Method {
        switch self {
        case .fetchWeather:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case let .fetchWeather(lat, long):
            return .requestParameters(parameters: ["appid": "2123da90c60a5720c36c1ca633b8daeb",
                                                   "lat": lat,
                                                   "lon": long,
                                                   "units": "metric"]
                                      , encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        nil
    }
}


