import Foundation

final class URLSessionWeatherProvider: WeatherProvider {
    
    private let url = "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8&q="
 
    func getWeatherForecast(for city: String, callback: @escaping (Result<WeatherForecast, WeatherProviderError>) -> ()) {
        guard let requestURL = URL(string: "\(url)\(city)") else {
            callback(.failure(.invalidRequestUrl))
            return
        }
        let request = URLRequest(url: requestURL)
        URLSession.shared.dataTask(with: request) { text, response, error in
            if let error = error {
                callback(.failure(.error(error.localizedDescription)))
                return
            }
            let responseStatusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            guard (200...299).contains(responseStatusCode) else {
                callback(.failure(.requestFailed(responseStatusCode)))
                return
            }
            guard let json = text else {
                callback(.failure(.invalidResponseData))
                return
            }
            do {
                let response = try JSONDecoder().decode(WeatherForecastDto.self, from: json)
                let forecast = WeatherForecast(city: response.city.name, forecast: response.forecast.map(self.toModel))
                callback(.success(forecast))
            } catch {
                callback(.failure(.parsingFailed(error.localizedDescription)))
            }
        }.resume()
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
