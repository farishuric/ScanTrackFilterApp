//
//  GPSTrackerManager.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import Foundation
import CoreLocation

class GPSTrackerManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager = CLLocationManager()

    @Published var currentLocation: CLLocation?
    @Published var currentSpeed: CLLocationSpeed = 0.0
    @Published var traveledDistance: CLLocationDistance = 0.0

    override init() {
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func startTracking() {
        locationManager.startUpdatingLocation()
    }

    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate Methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location

            // Calculate the speed and distance from previous location
            if let previousLocation = currentLocation {
                let distance = location.distance(from: previousLocation)
                let timeInterval = location.timestamp.timeIntervalSince(previousLocation.timestamp)
                currentSpeed = distance / timeInterval  // Speed in meters per second
                traveledDistance += distance
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location tracking errors here
    }
}
