# Taco Finder 🌮

A quick and simple iOS app for finding nearby taco spots using SwiftUI, MapKit, and Core Location.

## Features

- **Real-time Location**: Uses Core Location to find your current position
- **Map View**: Interactive map showing nearby taco restaurants with taco emoji markers
- **List View**: Sorted list of taco spots by distance with ratings
- **Search**: Automatically searches for taco places within 5km of your location
- **Directions**: Tap any taco spot to open directions in Apple Maps

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+
- Physical device or simulator with location services

## Project Structure

```
TacoFinder/
├── TacoFinder/
│   ├── TacoFinderApp.swift         # App entry point
│   ├── Info.plist                   # App configuration & permissions
│   ├── Models/
│   │   └── TacoSpot.swift           # Taco restaurant data model
│   ├── Services/
│   │   ├── LocationManager.swift    # Core Location wrapper
│   │   └── TacoSearchService.swift  # MapKit search service
│   └── Views/
│       ├── ContentView.swift        # Main view with tab switcher
│       ├── TacoMapView.swift        # Map view with annotations
│       └── TacoListView.swift       # List view with taco spots
└── TacoFinder.xcodeproj/
    └── project.pbxproj              # Xcode project configuration
```

## Setup Instructions

### 1. Open in Xcode

```bash
open TacoFinder.xcodeproj
```

### 2. Configure Signing

1. Select the **TacoFinder** project in the navigator
2. Select the **TacoFinder** target
3. Go to **Signing & Capabilities**
4. Select your development team or enable "Automatically manage signing"

### 3. Run the App

1. Select a simulator or connected device
2. Press `Cmd + R` or click the Run button
3. When prompted, allow location access

## How to Use

1. **Launch**: Open the app and grant location permissions when prompted
2. **Auto-Search**: The app automatically searches for nearby tacos on first load
3. **Manual Search**: Tap "Find Tacos" in the navigation bar to refresh results
4. **Switch Views**: Use the segmented control to toggle between Map and List views
5. **Get Directions**: Tap any taco spot in the list to open directions in Apple Maps

## Technical Details

### Core Technologies

- **SwiftUI**: Modern declarative UI framework
- **MapKit**: For displaying maps and searching for places
- **Core Location**: For accessing user location
- **Combine**: For reactive data binding

### Key Components

#### LocationManager
Manages user location permissions and updates:
- Requests "When In Use" authorization
- Publishes current location via `@Published`
- Handles authorization state changes

#### TacoSearchService
Searches for nearby taco restaurants:
- Uses `MKLocalSearch` API
- Searches within 5km radius
- Calculates distances from user location
- Sorts results by proximity

#### TacoSpot Model
Represents a taco restaurant with:
- Name and address
- GPS coordinates
- Simulated rating (would integrate real reviews in production)
- Distance calculation and formatting

### Privacy & Permissions

The app requires location permission to function. The following usage descriptions are configured in `Info.plist`:

- `NSLocationWhenInUseUsageDescription`: "We need your location to find taco spots near you"

## Limitations & Future Improvements

### Current Limitations
- Ratings are simulated (random values between 3.5-5.0)
- Uses MapKit's place search (may not show all taco spots)
- No filtering options (e.g., price, cuisine type)

### Potential Enhancements
- Integrate Yelp or Google Places API for real ratings & reviews
- Add filters (price, rating, distance, open now)
- Save favorite taco spots
- Add user reviews and photos
- Show restaurant hours and phone numbers
- Support for offline caching

## License

MIT License - Feel free to use this code for your own projects!

## Author

Built with Claude Code
