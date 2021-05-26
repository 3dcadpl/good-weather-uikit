import Foundation

final class WeatherForecastViewModel {
    
    var forecast: [DayForecastViewModel] = []
    var cityName = ""
    var refreshFailed = false
    var refreshWeatherDelegate: Task?
    
    private let cityKey = "cityName"
    private let icons = ["01d": "sun.max.fill", "02d": "cloud.sun.fill", "03d": "cloud.fill", "04d": "smoke.fill", "09d": "cloud.rain.fill", "10d": "cloud.sun.rain.fill", "11d": "cloud.sun.bolt.fill", "13d": "snow", "50d": "cloud.fog.fill"]
    private let getWeatherUseCase: GetWeatherUseCase
    private let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    init(getWeatherUseCase: GetWeatherUseCase) {
        self.getWeatherUseCase = getWeatherUseCase
        if let cityName = UserDefaults.standard.string(forKey: cityKey) {
            refreshWeatherForecast(for: cityName)
        }
    }
    
    func refreshWeatherForecast(for city: String) {
        refreshFailed = false
        getWeatherUseCase.getWeatherForecast(for: city, callback: onWeatherForecast)
    }
    
    private func onWeatherForecast(_ result: (Result<WeatherForecast, GetWeatherFailed>)) -> () {
        switch result {
        case .success(let weatherForecast):
            UserDefaults.standard.set(weatherForecast.city, forKey: self.cityKey)
            cityName = weatherForecast.city
            self.forecast = weatherForecast.forecast.map(self.toViewModel)
        case .failure(_):
            self.refreshFailed = true
        }
        refreshWeatherDelegate?.onComplete()
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
