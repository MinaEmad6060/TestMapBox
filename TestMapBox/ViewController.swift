//
//  ViewController.swift
//  TestMapBox
//
//  Created by Mina Emad on 07/10/2024.
//


import UIKit
import MapboxMaps
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation

class ViewController: UIViewController {
    var mapView: NavigationMapView!

    // Driver location = -122.029804, 37.331978
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the NavigationMapView and add it to the view
        mapView = NavigationMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
        // Define waypoints
        let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 31.272759797580306, longitude: 30.000467341949246), name: "Cupertino")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 31.274679364019207, longitude: 30.00385765410985), name: "Mt. Tam")

        // Create route options
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
   

        Directions.shared.calculate(routeOptions) { session, result in
            switch result {
            case .failure(let error):
                print("Error calculating route: \(error)")
            case .success(let response):
                // Display the routes on the map
                if let routes = response.routes, !routes.isEmpty {
                    self.mapView.showcase(routes)
                    print("Directions-MapBox-response \(result)")

                    // Create IndexedRouteResponse
                    let indexedRouteResponse = IndexedRouteResponse(routeResponse: response, routeIndex: 0)

                    // Extract RouteResponse and routeIndex
                    let routeResponse = indexedRouteResponse.routeResponse // Extracting RouteResponse
                    let routeIndex = indexedRouteResponse.routeIndex // Extracting the route index
                    
                    // Create the navigation service without simulation
                    let navigationService = MapboxNavigationService(routeResponse: routeResponse, routeIndex: routeIndex, routeOptions: routeOptions, simulating: .none) // No simulation

                    // Set up navigation options
                    let navigationOptions = NavigationOptions(
                        styles: nil, // Use default styles or customize if needed
                        navigationService: navigationService,
                        // Remove voiceController if not needed
                        voiceController: nil, // Use nil or remove this line entirely if you don't need a custom voice controller
                        topBanner: nil, // You can add a custom top banner if needed
                        bottomBanner: nil, // You can add a custom bottom banner if needed
                        predictiveCacheOptions: nil, // Use predictive caching if needed
                        navigationMapView: nil, // If you have a custom map view, pass it here, else it'll use the default map
                        simulationMode: .none // Disable simulation mode
                    )

                    // Initialize NavigationViewController with RouteResponse and navigation options
                    let navigationViewController = NavigationViewController(for: routeResponse, routeIndex: routeIndex, routeOptions: routeOptions, navigationOptions: navigationOptions)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.present(navigationViewController, animated: true)
                    }
                } else {
                    print("No routes found.")
                }
            }
        }

    }
}

