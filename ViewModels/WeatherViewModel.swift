
import Foundation
import Combine



@MainActor
class WeatherViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let service = WeatherService()
    
    func fetchWeather(for city: String) async {
        
       
        isLoading = true
        errorMessage = nil
        
        do {
            
            weather = try await service.fetchWeather(for: city)
            
        } catch {
            
            errorMessage = "Ville introuvable 😕"
            weather = nil
        }
        
    
        isLoading = false
    }
}
