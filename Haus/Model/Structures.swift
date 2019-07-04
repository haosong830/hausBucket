//
//  Models.swift
//  Haus
//
//  Created by Qingyang Liu on 7/4/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import Foundation
import UIKit

struct DataInfo{
    var longitude: Double
    var latitude: Double
    var altitude: Double
    var text: String
    var image: UIImage
}

struct Tag: Decodable{
    var latitude: Double=0
    var longitude: Double
    var text: String
}
