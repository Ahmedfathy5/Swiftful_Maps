//
//  Locations.swift
//  SwiftfulMapApp
//
//  Created by Ahmed Fathi on 21/09/2023.
//

import Foundation
import MapKit


struct Location: Identifiable , Equatable {
   
    
    var id :String {
        name + cityName
    }
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description : String
    let imageNames: [String]
    let link: String
    
    
    //MARK: - Equtable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
