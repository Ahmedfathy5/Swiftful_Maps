//
//  LocationViewDetail.swift
//  SwiftfulMapApp
//
//  Created by Ahmed Fathi on 21/10/2023.
//

import SwiftUI
import MapKit

struct LocationViewDetail: View {
    @EnvironmentObject private var vm : locationsViewModel  
    let location: Location
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 16.0) {
               titleSection
                    Divider()
                    DescriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding()
            }
           
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

struct LocationViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        LocationViewDetail(location: LocationsDataService.locations.first!)
    }
}
extension LocationViewDetail {
    private var imageSection : some View {
        TabView {
            ForEach(location.imageNames ,id:\.self ) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                   .frame(width: UIScreen.main.bounds.width)
                   .clipped()
                
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
            
            
        }
    }
    private var DescriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            
            if  let url = URL(string: location.link) {
                Link("Read more on wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
            
            
        }
    }
    private var mapLayer : some View {
        
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotionView()
                    .shadow(radius: 10)
            }
        }
            .disabled(true)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30 )
    }
    private var backButton :some View {
        Button {
            vm.sheetLocation = nil 
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }

    }
        
}
