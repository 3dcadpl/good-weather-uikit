class ApplicationFactory {
    
    static var shared: ApplicationFactory = { ApplicationFactory() }()
    
    private init() {
    }
    
    private lazy var weatherProvider = { URLSessionWeatherProvider() }()
    private lazy var getWeatherUseCase = { GetWeatherService(weatherProvider: self.weatherProvider) }()
    
    lazy var weatherForecastViewModel = { WeatherForecastViewModel(getWeatherUseCase: self.getWeatherUseCase) }()
    
}
