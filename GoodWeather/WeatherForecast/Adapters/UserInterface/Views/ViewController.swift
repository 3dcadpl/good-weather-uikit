import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = URLSessionWeatherProvider()
        provider.getWeatherForecast(for: "warsaw", callback: onForecastLoaded)
    }

    private func onForecastLoaded(result: Result<WeatherForecast, WeatherProviderError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let forecast):
                print(forecast.city)
            case .failure(let error):
                print(error)
            }
        }
       
    }
    
}
