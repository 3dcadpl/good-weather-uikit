struct WeatherForecastDto: Decodable {
    
    let city: CityDto
    let forecast: [DayForecastDto]
    
    enum CodingKeys: String, CodingKey {
        
        case city
        case forecast = "list"
            
    }
    
}
