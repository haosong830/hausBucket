//
//  HelperExtensions.swift
//  Haus
//
//  Created by Tom Berg on 7/3/19.
//  Copyright © 2019 Qingyang Liu. All rights reserved.
//

import Foundation
import UIKit

// found on stack overflow
extension String {
    // converts a string to a UIImage
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
