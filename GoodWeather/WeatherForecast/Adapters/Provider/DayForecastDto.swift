struct DayForecastDto: Decodable {
    
    let date: Double
    let temperature: TemperatureDto
    let pressure: Double
    let weather: [WeatherDto]
    
    enum CodingKeys: String, CodingKey {
        
        case date = "dt"
        case temperature = "temp"
        case pressure
        case weather
            
    }
    
}
