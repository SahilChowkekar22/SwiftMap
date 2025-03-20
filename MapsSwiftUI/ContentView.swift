//
//  ContentView.swift
//  MapsSwiftUI
//
//  Created by Sahil ChowKekar on 3/6/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State var stateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.04444, longitude: -0.28),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    @StateObject var myLocationManager = MyLocationManager()

    var dynamicPosition: Binding<MapCameraPosition>? {
        guard let location = myLocationManager.currentlocation else {
            return MapCameraPosition.region(stateRegion).getBindingPosition()
        }

        let position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.1, longitudeDelta: 0.1)))
        return position.getBindingPosition()
    }
    var body: some View {
        NavigationStack {
            ZStack {
                //     Static Map           Map(coordinateRegion: $stateRegion)

                //dynamic map with usercurrent location and system pin
                //                if let position = dynamicPosition,
                //                    let currentlocation = myLocationManager.currentlocation
                //                {
                //                    Map(position: position){
                //                        Marker("My Location", coordinate: currentlocation.coordinate)
                //                    }
                //                }

                // custom Marker with dynamic position
                if let position = dynamicPosition,
                    let currentlocation = myLocationManager.currentlocation
                {
                    Map(position: position) {
                        Marker(coordinate: currentlocation.coordinate) {
                            MapPin(name: "Current Location")
                        }
                    }
                }

            }.ignoresSafeArea()
        }
        //        .padding()
    }

}
#Preview {
    ContentView()
}
