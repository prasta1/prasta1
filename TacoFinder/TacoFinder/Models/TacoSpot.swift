import Foundation
import CoreLocation
import MapKit

struct TacoSpot: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let rating: Double
    let distance: Double? // in meters

    var distanceString: String {
        guard let distance = distance else { return "Unknown" }
        let miles = distance * 0.000621371 // Convert meters to miles
        return String(format: "%.1f mi", miles)
    }

    var mapItem: MKMapItem {
        let placemark = MKPlacemark(coordinate: coordinate)
        let item = MKMapItem(placemark: placemark)
        item.name = name
        return item
    }
}

// Extension for map annotations
extension TacoSpot {
    var annotation: TacoAnnotation {
        TacoAnnotation(tacoSpot: self)
    }
}

class TacoAnnotation: NSObject, Identifiable {
    let id = UUID()
    let tacoSpot: TacoSpot

    init(tacoSpot: TacoSpot) {
        self.tacoSpot = tacoSpot
    }

    var coordinate: CLLocationCoordinate2D {
        tacoSpot.coordinate
    }
}
