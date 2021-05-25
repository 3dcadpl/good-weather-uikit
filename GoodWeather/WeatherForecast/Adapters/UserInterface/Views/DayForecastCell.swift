import UIKit

class DayForecastCell: UITableViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    func update(dayForecast: DayForecastViewModel) {
        weatherImageView.image = UIImage(systemName: dayForecast.icon)
        descriptionLabel.text = dayForecast.description
        temperatureLabel.text = dayForecast.temperature
        pressureLabel.text = dayForecast.pressure
    }
    
}
