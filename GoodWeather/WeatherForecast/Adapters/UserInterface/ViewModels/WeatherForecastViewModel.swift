import Foundation

struct WeatherForecastViewModel {
    
    let forecast: [DayForecastViewModel] = []
    
    private let weatherProvider: WeatherProvider
    private let dateformatter = DateFormatter()
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        dateformatter.dateFormat = "E"
    }
    
}
