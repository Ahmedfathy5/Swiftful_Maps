//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Ahmed Fathi on 21/09/2023.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    @StateObject private var vm = locationsViewModel()
    var body: some Scene {
        WindowGroup {
           LocationsView()
                .environmentObject(vm)
        }
    }
}
