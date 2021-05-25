import UIKit

class ForecastDetailsViewController: UITableViewController {

    var viewModel: WeatherForecastViewModel!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.forecast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayForecastCell") as! DayForecastCell
        cell.update(dayForecast: viewModel.forecast[indexPath.row])
        return cell
    }
    
}
