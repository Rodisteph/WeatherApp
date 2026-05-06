

import Foundation



class WeatherService {
    
 
    private let apiKey = "edd4f9f7e0f9007dd44d32174599e9fe"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        
        
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric&lang=fr"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
       
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
     
        let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return weather
    }
}
