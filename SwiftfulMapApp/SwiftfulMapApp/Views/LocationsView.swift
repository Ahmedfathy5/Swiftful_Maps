//
//  LocationView.swift
//  SwiftfulMapApp
//
//  Created by Ahmed Fathi on 21/09/2023.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    @EnvironmentObject private var vm: locationsViewModel
   
  
    var body: some View {
        ZStack{
          mapLayer
                .ignoresSafeArea()
            
            VStack( spacing: 0) {
           header
                .padding()
                Spacer()
                locationsPreviewStack
             
            }
        }
        .sheet(item: $vm.sheetLocation) { location in
            LocationViewDetail(location: location)
        }
        
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(locationsViewModel())
    }
}


extension LocationsView {
    private var header : some View {
        VStack {
            Button {
                withAnimation {
                    vm.toggleListLocation()
                }
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: vm.mapLocation)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: vm.showLocationList ? 270 : 0))
                }
            }

            if vm.showLocationList {
                LocationsListView()
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    private var mapLayer : some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotionView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    private var locationsPreviewStack : some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
               
            }
        }
    }
}
