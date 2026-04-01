
import Foundation
import Combine



@MainActor
class WeatherViewModel: ObservableObject {
    
    // 📡 Les données que la View va afficher
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let service = WeatherService()
    
    func fetchWeather(for city: String) async {
        
        // 1. On démarre le chargement
        isLoading = true
        errorMessage = nil
        
        do {
            // 2. On appelle le service
            weather = try await service.fetchWeather(for: city)
            
        } catch {
            // 3. Si erreur → on affiche un message
            errorMessage = "Ville introuvable 😕"
            weather = nil
        }
        
        // 4. Chargement terminé
        isLoading = false
    }
}
