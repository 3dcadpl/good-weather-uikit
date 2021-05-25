import Foundation

struct WeatherForecastViewModel {
    
    let forecast: [DayForecastViewModel] = []
    
    private let icons = ["01d": "sun.max.fill", "02d": "cloud.sun.fill", "03d": "cloud.fill", "04d": "smoke.fill", "09d": "cloud.rain.fill", "10d": "cloud.sun.rain.fill", "11d": "cloud.sun.bolt.fill", "13d": "snow", "50d": "cloud.fog.fill"]
    private let weatherProvider: WeatherProvider
    private let dateformatter = DateFormatter()
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        dateformatter.dateFormat = "E"
    }
    
}
