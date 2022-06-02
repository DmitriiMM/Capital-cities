//
//  Capitals.swift
//  Project16
//
//  Created by Дмитрий Мартынов on 01.12.2021.
//

import UIKit
import MapKit

class Capitals: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
