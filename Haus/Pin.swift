//
//  Pin.swift
//  Haus
//
//  Created by Tom Berg on 7/2/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import MapKit
import Contacts

class Pin: NSObject, MKAnnotation {
    // will be displayed when the user taps the pin Note: we can add subtitles or whatever else we want the pins to display when they're tapped on
    let title: String?
    // each pin should be uniquely identifiable, we can make this an int or put it in a hashtable or something too
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D // 2D location of the pin. Note: later we will make this 3D
    
    // markerTintColor for disciplines: Educational, Apartment, House, Gym, other
    var markerTintColor: UIColor  {
        switch discipline {
        case "Educational":
            return .red
        case "Apartment":
            return .cyan
        case "House":
            return .blue
        case "Gym":
            return .purple
        case "Landmark":
            return .magenta
        default:
            return .green
        }
    }
    
    // to make the pin marker look less boring
    var imageName: String? {
        if discipline == "Educational" { return "Educational" }
        return "Default"
    }
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        
        super.init()
    }
    
    //// TODO: update this method so that it can parse a json file/object
    init?(json: [Any]) {
        self.title = "TODO: parse the json file"
        self.locationName = "TODO: parse the json file"
        self.discipline = "TODO: parse the json file"
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
    }
    
    
    // TODO: look into if we need the subtitle part - it depends on what we want pins to do
    var subtitle: String? {
        return locationName
    }
    
    // TODO: maybe add a function that will open up directions to get to the pin in maps
    // Note: I think you add this inside of the mapview function in the mainviewcontroller extension
    
    // this adds the pins that we want on the map when the app is loaded
    static public func addBeginningAnnotations(mapView: MKMapView!) {
        
        // put a pin on the CS building
        let firstPin = Pin(title: "This is the title",
                           locationName: "Computer Sciences and Statistics",
                           discipline: "Educational",
                           coordinate: CLLocationCoordinate2D(latitude: 43.071655, longitude: -89.406677))
        mapView.addAnnotation(firstPin)
        
        // the pin class overrides/extends the annotation class so we can just make a new pin
        let secondPin = Pin(title: "New User1",
                            locationName: "Golden Gate Bridge",
                            discipline: "Landmark",
                            coordinate: CLLocationCoordinate2D(latitude: 37.8199, longitude: -122.4783))
        mapView.addAnnotation(secondPin)
        
    }
}
