import Foundation

final class URLSessionForecastProvider: ForecastProvider {
    
    private let url = "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8&q="
 
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ()) {
        guard let requestURL = URL(string: "\(url)\(city)") else {
            callback(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: requestURL)
        URLSession.shared.dataTask(with: request) { text, response, error in
            guard error == nil, let json = text else {
                callback(.failure(.requestFailed))
                return
            }
            if let responseDto = try? JSONDecoder().decode(ResponseDto.self, from: json) {
                let forecast = self.toModel(responseDto: responseDto)
                callback(.success(forecast))
            } else {
                callback(.failure(.parsingFailed))
            }
        }.resume()
    }
    
    private func toModel(responseDto: ResponseDto) -> Forecast {
        let city = responseDto.city
        let forecast = responseDto.forecast.map(toModel)
        return Forecast(id: city.id, city: city.name, forecast: forecast)
    }
    
    private func toModel(dayForecastDto: DayForecastDto) -> DayForecast {
        let date = Date(timeIntervalSince1970: dayForecastDto.date)
        let temperature = dayForecastDto.temperature.day
        let pressure = dayForecastDto.pressure
        let icon = dayForecastDto.weather.first?.icon ?? ""
        let description = dayForecastDto.weather.first?.description ?? ""
        return DayForecast(date: date, temperature: temperature, pressure: pressure, icon: icon, description: description)
    }
    
}
