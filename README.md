# Green

**Green** is an `iOS app` built to help reduce traffic emissions by guiding drivers toward routes with the fewest stops possible. 

Each time a user completes a low-emission route, they earn *Green Points*. These points can be redeemed for exclusive discounts or perks from environmentally conscious sponsors like **WWF**, **National Geographic**, and others who support sustainability and climate-friendly initiatives.

## Links

- [Devpost link](https://devpost.com/software/green-aed7s9) 🏆 **Winner – Best Sustainability Hack at Rensselaer Polytechnic Institute**
- [GitHub Link](https://github.com/mravaloarison/Green)

## How I Built It

I developed *Green* using:

- **Swift**
- **SwiftUI**
- **MapKit**

This project was my first hands-on experience with **MapKit**, and I built features like real-time routes visualization and location-based search with autocomplete.

### Place Autocompletion with MapKit

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

This was my first time working with MapKit, and it didn’t come with the easiest documentation or community support, especially during a hackathon with no mentors for Swift. I spent several hours digging through documentation, StackOverflow, ChatGPT, and YouTube tutorials to figure out the tools and build out the features I had in mind.

But in the end, every minute of effort was worth it and the project is now something I’m truly proud of.
