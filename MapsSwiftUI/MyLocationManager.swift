//
//  MyLocationManager.swift
//  MapsSwiftUI
//
//  Created by Sahil ChowKekar on 3/6/25.
//

import CoreLocation
import Foundation
import _MapKit_SwiftUI
import SwiftUI

class MyLocationManager: NSObject, ObservableObject {

    private var locationManger = CLLocationManager()

    @Published var currentlocation: CLLocation?

    @Published var postion: MapCameraPosition?

    override init() {
        super.init()
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.distanceFilter = kCLHeadingFilterNone
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
}

extension MyLocationManager: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {

        DispatchQueue.main.async {
            guard let lastLocation = locations.last else { return }
            self.currentlocation = lastLocation
            self.postion = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: lastLocation.coordinate.latitude,
                        longitude: lastLocation.coordinate.longitude),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.1, longitudeDelta: 0.1)))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}

extension MapCameraPosition{
    func getBindingPosition() -> Binding<MapCameraPosition> {
        return Binding<MapCameraPosition>.constant(self)
    }
    
}
