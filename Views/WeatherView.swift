import SwiftUI

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityName: String = ""
    
    var body: some View {
        ZStack {
            // 🎨 Fond dégradé
            LinearGradient(
                colors: [.blue.opacity(0.8), .cyan.opacity(0.5)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                // 🔍 Barre de recherche
                HStack {
                    TextField("Entrez une ville...", text: $cityName)
                        .padding()
                        .background(.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    
                    Button {
                        Task {
                            await viewModel.fetchWeather(for: cityName)
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .background(.white.opacity(0.2))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                // ⏳ Chargement
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.5)
                }
                
                // ❌ Erreur
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                // ✅ Données météo
                if let weather = viewModel.weather {
                    VStack(spacing: 16) {
                        
                        // Ville
                        Text(weather.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        // Icône + Température
                        Text("\(Int(weather.main.temp))°C")
                            .font(.system(size: 72, weight: .thin))
                            .foregroundColor(.white)
                        
                        // Description
                        Text(weather.weather.first?.description ?? "")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.8))
                            .textCase(.uppercase)
                        
                        // Détails
                        HStack(spacing: 32) {
                            WeatherDetailRow(
                                icon: "thermometer",
                                label: "Ressenti",
                                value: "\(Int(weather.main.feelsLike))°C"
                            )
                            WeatherDetailRow(
                                icon: "drop.fill",
                                label: "Humidité",
                                value: "\(weather.main.humidity)%"
                            )
                            WeatherDetailRow(
                                icon: "wind",
                                label: "Vent",
                                value: "\(Int(weather.wind.speed)) m/s"
                            )
                        }
                        .padding()
                        .background(.white.opacity(0.15))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    WeatherView()
}
