import SwiftUI
import MapKit

struct TacoListView: View {
    let tacoSpots: [TacoSpot]

    var body: some View {
        List {
            ForEach(tacoSpots) { spot in
                Button(action: {
                    openInMaps(spot)
                }) {
                    TacoSpotRow(spot: spot)
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private func openInMaps(_ spot: TacoSpot) {
        spot.mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

struct TacoSpotRow: View {
    let spot: TacoSpot

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("🌮")
                .font(.system(size: 40))

            VStack(alignment: .leading, spacing: 4) {
                Text(spot.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(spot.address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                HStack {
                    HStack(spacing: 2) {
                        ForEach(0..<Int(spot.rating), id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.yellow)
                        }
                        if spot.rating.truncatingRemainder(dividingBy: 1) >= 0.5 {
                            Image(systemName: "star.leadinghalf.filled")
                                .font(.caption)
                                .foregroundColor(.yellow)
                        }
                    }

                    Text(String(format: "%.1f", spot.rating))
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if let distance = spot.distance {
                        Text("•")
                            .foregroundColor(.secondary)
                        Text(spot.distanceString)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
