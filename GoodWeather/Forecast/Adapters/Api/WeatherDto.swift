import Foundation

struct WeatherDto: Decodable {

    let info: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        
        case info = "main"
        case description
        case icon
            
    }
    
}
