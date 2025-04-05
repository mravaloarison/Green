# 🌿 Green – Emission-Aware Routing App

**Devpost:** [[Your Devpost Link Here](https://devpost.com/software/green-aed7s9)]  
**GitHub:** [[Your GitHub Link Here](https://github.com/mravaloarison/Green)]

## 🚗 What It Does

**Green** is a mobile app built to help reduce traffic emissions by guiding drivers toward routes with the fewest stops possible. The app intelligently analyzes real-time traffic data using MapKit and avoids congestion hotspots by recommending alternate, cleaner routes — even if those routes might take a bit longer.

Each time a user completes a low-emission route, they earn *Green Points*. These points can be redeemed for exclusive discounts or perks from environmentally conscious sponsors like **WWF**, **National Geographic**, and others who support sustainability and climate-friendly initiatives.

## 🛠️ How I Built It

I developed *Green* using:

- **Swift**
- **SwiftUI**
- **MapKit**

This project was my first hands-on experience with **MapKit**, and I built features like real-time traffic visualization and location-based search with autocomplete.

### 🔍 Sample: Place Autocompletion with MapKit

```swift
import MapKit

class PlaceVM: ObservableObject {
    @Published var placesFound: [Place] = []
    
    func search(text: String, region: MKCoordinateRegion) {
        let req = MKLocalSearch.Request()
        req.naturalLanguageQuery = text
        req.region = region
        let search = MKLocalSearch(request: req)
        
        search.start { response, error in
            guard let res = response else {
                print("PlaceVM error \(String(describing: error))")
                return
            }
            
            self.placesFound = res.mapItems.map(Place.init)
        }
    }
}
```

MapKit also provides a simple way to show traffic with:

```swift
@MainActor
var showsTraffic: Bool { get set }
```

This allows the app to detect and visualize high-traffic zones so the user can be rerouted accordingly.

## 🚧 Challenges I Ran Into

This was my first time working with MapKit, and it didn’t come with the easiest documentation or community support, especially during a hackathon with no mentors for Swift. I spent several hours digging through documentation, StackOverflow threads, and YouTube tutorials to figure out the tools and build out the features I had in mind.

But in the end, every minute of effort was worth it. I gained confidence working with native iOS frameworks, and the project evolved into something I’m truly proud of.
