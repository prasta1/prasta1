import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var searchService = TacoSearchService()

    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    // Tab Picker
                    Picker("View", selection: $selectedTab) {
                        Text("Map").tag(0)
                        Text("List").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    // Content
                    if searchService.isSearching || locationManager.isLoading {
                        Spacer()
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Finding tacos nearby...")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    } else if searchService.tacoSpots.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Text("🌮")
                                .font(.system(size: 80))
                            Text("No taco spots found yet")
                                .font(.headline)
                            Text("Tap the button below to search")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    } else {
                        if selectedTab == 0 {
                            TacoMapView(
                                tacoSpots: searchService.tacoSpots,
                                userLocation: locationManager.location
                            )
                        } else {
                            TacoListView(tacoSpots: searchService.tacoSpots)
                        }
                    }
                }

                // Error message
                if let error = searchService.errorMessage {
                    VStack {
                        Spacer()
                        Text(error)
                            .padding()
                            .background(Color.red.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
                }
            }
            .navigationTitle("Taco Finder")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: searchForTacos) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Find Tacos")
                        }
                    }
                    .disabled(locationManager.isLoading || searchService.isSearching)
                }
            }
            .onAppear {
                locationManager.requestLocation()
            }
            .onChange(of: locationManager.location) { location in
                if let location = location, searchService.tacoSpots.isEmpty {
                    Task {
                        await searchService.searchNearbyTacos(near: location)
                    }
                }
            }
        }
    }

    private func searchForTacos() {
        if let location = locationManager.location {
            Task {
                await searchService.searchNearbyTacos(near: location)
            }
        } else {
            locationManager.requestLocation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
