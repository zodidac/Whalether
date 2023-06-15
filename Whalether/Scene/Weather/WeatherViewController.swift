import UIKit
import MapKit

protocol WeatherDisplayLogic: AnyObject {
    func displayWeather(viewModel: Weather.GetWeatherReport.ViewModel)
    func displayWeatherFailed(message: String)
}

class WeatherViewController: UIViewController {
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var tempLabel: UILabel!
    @IBOutlet private var humudityLabel: UILabel!
    @IBOutlet private var windSpeedLabel: UILabel!
    @IBOutlet private var weatherDescriptionLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var tableViewHeight: NSLayoutConstraint!
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var interactor: WeatherBusinessLogic?
    var router: (NSObjectProtocol & WeatherRoutingLogic & WeatherDataPassing)?
    var forecastData: [Weather.ForecastDaily] = []
    var timer = Timer()
    
    public static func initiated() -> WeatherViewController? {
        let storyboard = UIStoryboard(name: "WeatherViewControllerStoryboard", bundle: nil)
        guard let vc: WeatherViewController = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else { return nil }
        vc.setup()
        return vc
    }
    
    private func setup() {
        let viewController = self
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let router = WeatherRouter()
        let worker = WeatherWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isHidden = true
        locManager.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTableViewCell")
        locManager.requestWhenInUseAuthorization()
        NotificationCenter.default.addObserver(self, selector: #selector(userChanged), name: Notification.Name("UserChanged"), object: nil)
    }
    
    private func getLocation() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            guard let currentLocation = locManager.location else {
                return
            }
            interactor?.requestWeatherReport(request: Weather.GetWeatherReport.Request(lat: currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude))
        }
    }
    
    @objc func userChanged() {
        getLocation()
    }
    
    @IBAction func profileTapped() {
        router?.routeToUserProfile()
    }
}

extension WeatherViewController: WeatherDisplayLogic {
    func displayWeather(viewModel: Weather.GetWeatherReport.ViewModel) {
        tempLabel.text = viewModel.temp
        humudityLabel.text = viewModel.humidity
        windSpeedLabel.text = viewModel.windSpeed
        weatherDescriptionLabel.text = viewModel.description
        forecastData = viewModel.daily
        tableView.reloadData()
        tableViewHeight.constant = tableView.contentSize.height
        scrollView.isHidden = false
    }
    
    func displayWeatherFailed(message: String) {
        let alert = UIAlertController(title: "Something when wrong", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.getLocation()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ForecastTableViewCell = tableView.dequeue(ForecastTableViewCell.self)
        cell.backgroundColor = .clear
        let index = indexPath.row
        cell.updateCell(day: forecastData[index].day, minTemp: forecastData[index].minTemp, maxTemp: forecastData[index].maxTemp)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("not determined - hence ask for Permission")
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            let alert = UIAlertController(title: "Cannot access to location", message: "Please allow application access to your location", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Setting", style: UIAlertAction.Style.default, handler: {_ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }))
            self.present(alert, animated: true, completion: nil)
        case .authorizedAlways, .authorizedWhenInUse:
            print("Apple delegate gives the call back here once user taps Allow option, Make sure delegate is set to self")
            getLocation()
            self.timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: {[weak self] _ in
                guard let self = self else { return }
                self.getLocation()
            })
        }
    }
}
