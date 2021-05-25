protocol WeatherProvider {
    
    func getWeatherForecast(for city: String, callback: @escaping (Result<WeatherForecast, WeatherProviderError>) -> ())
    
}
