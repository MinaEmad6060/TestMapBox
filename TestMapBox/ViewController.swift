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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the NavigationMapView and add it to the view
        mapView = NavigationMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)

        // Define waypoints
        let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.33317708998446, longitude: -122.0086669921875), name: "Cupertino")
        let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.929575667562325, longitude: -122.57858276367186), name: "Mt. Tam")

        // Create route options
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])

        // Calculate the route
        Directions.shared.calculate(routeOptions) { session, result in
            switch result {
            case .failure(let error):
                print("Error calculating route: \(error)")
            case .success(let response):
                // Display the routes on the map
                if let routes = response.routes {
                    self.mapView.showcase(routes)
                    print("Directions-MapBox-response \(result)")
                    let navigationViewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        self.present(navigationViewController, animated: true)
                    }
                } else {
                    print("No routes found.")
                }
            }
        }
    }
}


