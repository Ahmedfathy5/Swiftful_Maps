//
//  LocationsViewModel.swift
//  SwiftfulMapApp
//
//  Created by Ahmed Fathi on 21/09/2023.
//

import SwiftUI
import MapKit

class locationsViewModel: ObservableObject {
    @Published var locations : [Location]
    @Published var mapLocation : Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
        //MARK: - Current region on map
    @Published  var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1 )
    
    //MARK: - Show list of Locations
    @Published var showLocationList = false
    
    //MARK: - show location View via sheet
    @Published var sheetLocation : Location? = nil
    
  
    
    
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    func updateMapRegion (location: Location){
    
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
    }
    func toggleListLocation() {
        showLocationList.toggle()
    }
    
    func showNextLocation (location: Location){
        
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    
    func nextButtonPressed () {
        //MARK: - Get the Current index
        guard let currentIndex = locations.firstIndex (where: {$0 == mapLocation })  else {return}
        
        //MARK: - Check if the current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            
            //MARK: - next index is Not Valid
            //MARK: - Restart from 0
            guard let firstIndex = locations.first else {return}
            showNextLocation(location: firstIndex)
            
            return
            
        }
        let nextLocations = locations[nextIndex]
        showNextLocation(location: nextLocations)
    }
}
