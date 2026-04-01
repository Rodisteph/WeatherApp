

import Foundation



class WeatherService {
    
    // 🔑 Remplace par ta vraie clé ici
    private let apiKey = "edd4f9f7e0f9007dd44d32174599e9fe"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        
        // 1. Construction de l'URL
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric&lang=fr"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // 2. Appel réseau
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // 3. Vérification que l'API répond bien (code 200)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // 4. Décodage JSON → WeatherResponse
        let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return weather
    }
}
