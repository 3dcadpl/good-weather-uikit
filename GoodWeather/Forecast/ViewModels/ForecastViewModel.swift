import Foundation

struct ForecastViewModel {
    
    let forecast: [DayForecastViewModel] = []
    
    private let forecastProvider: ForecastProvider
    private let dateformatter = DateFormatter()
    
    init(forecastProvider: ForecastProvider) {
        self.forecastProvider = forecastProvider
        dateformatter.dateFormat = "E"
    }
    
}
