//import UIKit
//import MapboxCoreNavigation
//import MapboxNavigation
//import MapboxDirections
//import CoreLocation
//
//class ViewController2: UIViewController, CLLocationManagerDelegate, NavigationViewControllerDelegate {
//    
//    private var locationManager: CLLocationManager!
//    private var navigationService: NavigationService?
//    private var route: Route?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Initialize Core Location
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        
//        // Define the starting and ending points
//        let origin = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco
//        let destination = CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437) // Los Angeles
//        
//        // Create a route from the origin to the destination
//        let options = NavigationRouteOptions(coordinates: [origin, destination])
//        
//        // Request the route from Mapbox Directions API
//        Directions.shared.calculate(options) { [weak self] (session, result) in
//            switch result {
//            case .failure(let error):
//                print("Error calculating route: \(error.localizedDescription)")
//            case .success(let response):
//                guard let route = response.routes?.first else { return }
//                self?.route = route
//            }
//        }
//    }
//    
//    // MARK: - CLLocationManagerDelegate
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        
//        // Check if the device is moving
//        if location.speed > 0 {
//            // Start navigation if not already started
//            if navigationService == nil {
//                startNavigation()
//            }
//        }
//    }
//    
//    private func startNavigation() {
//        guard let route = route else { return }
//        
//        let navigationService = MapboxNavigationService(route: route, routeIndex: 0, routeOptions: route.routeOptions!)
//        let navigationOptions = NavigationOptions(navigationService: navigationService)
//        
//        let navigationViewController = NavigationViewController(for: route, navigationOptions: navigationOptions)
//        navigationViewController.delegate = self
//        
//        // Present the navigation view controller
//        present(navigationViewController, animated: true, completion: nil)
//        
//        self.navigationService = navigationService
//    }
//    
//    // MARK: - NavigationViewControllerDelegate
//    
//    func navigationViewController(_ navigationViewController: NavigationViewController, didArriveAt waypoint: Waypoint) -> Bool {
//        // Handle arrival at the destination
//        print("Arrived at destination")
//        return true
//    }
//}
