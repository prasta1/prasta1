import SwiftUI
import MapKit

struct TacoMapView: View {
    let tacoSpots: [TacoSpot]
    let userLocation: CLLocation?

    @State private var region: MKCoordinateRegion

    init(tacoSpots: [TacoSpot], userLocation: CLLocation?) {
        self.tacoSpots = tacoSpots
        self.userLocation = userLocation

        let center = userLocation?.coordinate ?? CLLocationCoordinate2D(
            latitude: 37.7749,
            longitude: -122.4194
        )

        _region = State(initialValue: MKCoordinateRegion(
            center: center,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        ))
    }

    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: tacoSpots) { spot in
            MapAnnotation(coordinate: spot.coordinate) {
                VStack(spacing: 0) {
                    Text("🌮")
                        .font(.title)
                        .shadow(radius: 3)

                    Text(spot.name)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .padding(4)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(4)
                        .shadow(radius: 2)
                }
            }
        }
        .onChange(of: userLocation) { newLocation in
            if let location = newLocation {
                withAnimation {
                    region.center = location.coordinate
                }
            }
        }
    }
}
