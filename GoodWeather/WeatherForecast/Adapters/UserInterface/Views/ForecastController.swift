import UIKit

class ForecastController: UIViewController, Task {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var viewModel = ApplicationFactory.shared.weatherForecastViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refreshWeatherDelegate = self
        title = "Good Weather"
        reset()
    }
    
    @IBAction func onRefresh(_ sender: UIButton) {
        if let city = cityTextField.text, !city.isEmpty {
            cityTextField.endEditing(true)
            viewModel.refreshWeatherForecast(for: city)
        }
    }

    private func reset() {
        descriptionLabel.text?.removeAll()
        temperatureLabel.text?.removeAll()
        pressureLabel.text?.removeAll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let forecastDetailsController = segue.destination as? ForecastDetailsViewController {
                forecastDetailsController.viewModel = viewModel
            }
        }
    }
    
    func onComplete() {
        DispatchQueue.main.async { [self] in
            if viewModel.refreshFailed {
                reset()
                descriptionLabel.text = "Refresh failed"
                weatherImageView.image = UIImage(systemName: "xmark.circle")
                return
            }
            if let dayForecast = viewModel.forecast.first {
                cityTextField.text = viewModel.cityName
                weatherImageView.image = UIImage(systemName: dayForecast.icon)
                descriptionLabel.text = dayForecast.description
                temperatureLabel.text = dayForecast.temperature
                pressureLabel.text = dayForecast.pressure
            }
        }
    }
    
}
