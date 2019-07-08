//
//  Annotation.swift
//  Haus
//
//  Created by Qingyang Liu on 7/5/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//


import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var text: String?
    
    init(coordinate: CLLocationCoordinate2D, text: String){
        self.coordinate=coordinate
        self.text=text
        super.init()
    }
    
    
}
