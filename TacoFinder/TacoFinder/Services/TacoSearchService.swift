import Foundation
import CoreLocation
import MapKit

class TacoSearchService: ObservableObject {
    @Published var tacoSpots: [TacoSpot] = []
    @Published var isSearching = false
    @Published var errorMessage: String?

    func searchNearbyTacos(near location: CLLocation) async {
        await MainActor.run {
            isSearching = true
            errorMessage = nil
        }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "tacos"
        request.region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )

        let search = MKLocalSearch(request: request)

        do {
            let response = try await search.start()

            let spots = response.mapItems.map { item -> TacoSpot in
                let distance = item.placemark.location?.distance(from: location)

                return TacoSpot(
                    name: item.name ?? "Unknown Taco Spot",
                    address: formatAddress(from: item.placemark),
                    coordinate: item.placemark.coordinate,
                    rating: 4.0 + Double.random(in: -0.5...1.0), // Simulated rating
                    distance: distance
                )
            }

            await MainActor.run {
                self.tacoSpots = spots.sorted { ($0.distance ?? .infinity) < ($1.distance ?? .infinity) }
                self.isSearching = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to find taco spots: \(error.localizedDescription)"
                self.isSearching = false
            }
        }
    }

    private func formatAddress(from placemark: MKPlacemark) -> String {
        var components: [String] = []

        if let street = placemark.thoroughfare {
            components.append(street)
        }
        if let city = placemark.locality {
            components.append(city)
        }
        if let state = placemark.administrativeArea {
            components.append(state)
        }

        return components.isEmpty ? "Address not available" : components.joined(separator: ", ")
    }
}
