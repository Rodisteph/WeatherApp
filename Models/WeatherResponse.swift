
import Foundation



// Ce que l'API OpenWeatherMap nous renvoie
struct WeatherResponse: Codable {
    let name: String          // Nom de la ville
    let main: MainWeather
    let weather: [WeatherInfo]
    let wind: Wind
}

struct MainWeather: Codable {
    let temp: Double          // Température en °C
    let humidity: Int         // Humidité en %
    let feelsLike: Double     // Ressenti

    // 🔑 L'API renvoie "feels_like" mais Swift préfère camelCase
    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
        case feelsLike = "feels_like"
    }
}

struct WeatherInfo: Codable {
    let description: String   // "clear sky", "light rain"...
    let icon: String          // Code icône ex: "01d"
}

struct Wind: Codable {
    let speed: Double         // Vitesse en m/s
}
