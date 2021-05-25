final class GetWeatherService: GetWeatherUseCase {
    
    private let weatherProvider: WeatherProvider
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
    }
    
    func getWeatherForecast(for city: String, callback: @escaping (Result<WeatherForecast, GetWeatherFailed>) -> ()) {
        weatherProvider.getWeatherForecast(for: city) { result in
            switch result {
            case .success(let forecast):
                callback(.success(forecast))
            case .failure(let error):
                print(error)
                callback(.failure(.error))
            }
        }
    }
    
}
