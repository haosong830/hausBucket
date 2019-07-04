//
//  PinViews.swift
//  Haus
//
//  Created by Tom Berg on 7/3/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import Foundation
import MapKit

/// This class is my attempt to let the user put emojis or pictures in pins
class PinMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let pin = newValue as? Pin else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            markerTintColor = pin.markerTintColor
        //    glyphText = String(pin.discipline.first!)
            var markerPic: String {
                switch pin.discipline {
                case "Educational":
                    return "📚"
                case "Apartment":
                    return "🏢"
                case "House":
                    return "🏡"
                case "Gym":
                    return "💉"
                case "Landmark":
                    return "➷"
                default:
                    return "String(pin.discipline.first!)"
                }
            }
       //     glyphText = markerPic
            if let imageName = pin.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
        }
    }
}

class PinView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let pin = newValue as? Pin else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let imageName = pin.imageName {
                image = "📚".image()
            } else {
                image = nil
            }
        }
    }
}




