import Foundation

final class WeatherForecastViewModel {
    
    var forecast: [DayForecastViewModel] = []
    var refreshFailed = false
    
    private let icons = ["01d": "sun.max.fill", "02d": "cloud.sun.fill", "03d": "cloud.fill", "04d": "smoke.fill", "09d": "cloud.rain.fill", "10d": "cloud.sun.rain.fill", "11d": "cloud.sun.bolt.fill", "13d": "snow", "50d": "cloud.fog.fill"]
    private let getWeatherUseCase: GetWeatherUseCase
    private let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    init(getWeatherUseCase: GetWeatherUseCase) {
        self.getWeatherUseCase = getWeatherUseCase
    }
    
    func refreshWeatherForecast(for city: String, callback: @escaping () -> ()) {
        refreshFailed = false
        getWeatherUseCase.getWeatherForecast(for: city) { response in
            switch response {
            case .success(let weatherForecast):
                self.forecast = weatherForecast.forecast.map(self.toViewModel)
            case .failure(_):
                self.refreshFailed = true
            }
            callback()
        }
    }
    
    private func toViewModel(dayForecast: DayForecast) -> DayForecastViewModel {
        let icon = icons[dayForecast.icon] ?? "xmark.circle"
        let description = dayForecast.description
        let temperature = "\(Int(dayForecast.temperature))°"
        let pressure = "\(Int(dayForecast.pressure))hPa"
        let date = dateformatter.string(from: dayForecast.date)
        return DayForecastViewModel(icon: icon, description: description, temperature: temperature, pressure: pressure, date: date)
    }
    
}
