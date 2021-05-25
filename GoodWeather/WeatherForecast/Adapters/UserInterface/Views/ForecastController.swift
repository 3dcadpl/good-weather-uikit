import UIKit

class ForecastController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var viewModel = ApplicationFactory.shared.weatherForecastViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Good Weather"
        reset()
    }
    
    @IBAction func onRefresh(_ sender: UIButton) {
        if let city = cityTextField.text, !city.isEmpty {
            cityTextField.endEditing(true)
            viewModel.refreshWeatherForecast(for: city, callback: updateView)
        }
    }
    
    @IBAction func onShowDetails(_ sender: UIButton) {
    }
    
    private func reset() {
        descriptionLabel.text?.removeAll()
        temperatureLabel.text?.removeAll()
        pressureLabel.text?.removeAll()
    }
    
    private func updateView() {
        DispatchQueue.main.async { [self] in
            if viewModel.refreshFailed {
                reset()
                descriptionLabel.text = "Refresh failed"
                weatherImageView.image = UIImage(systemName: "xmark.circle")
                return
            }
            if let dayForecast = viewModel.forecast.first {
                weatherImageView.image = UIImage(systemName: dayForecast.icon)
                descriptionLabel.text = dayForecast.description
                temperatureLabel.text = dayForecast.temperature
                pressureLabel.text = dayForecast.pressure
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let forecastDetailsController = segue.destination as? ForecastDetailsViewController {
                forecastDetailsController.viewModel = viewModel
            }
        }
    }
    
}
