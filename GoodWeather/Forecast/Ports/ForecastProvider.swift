protocol ForecastProvider {
    
    func getForecast(for city: String, callback: @escaping (Result<Forecast, ForecastProviderError>) -> ())
    
}
