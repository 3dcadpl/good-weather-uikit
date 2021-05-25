protocol GetWeatherUseCase {
    
    func getWeatherForecast(for city: String, callback: @escaping (Result<WeatherForecast, GetWeatherFailed>) -> ())
    
}
