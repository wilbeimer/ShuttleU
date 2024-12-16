//
//  ContentView.swift
//  ShuttleU
//
//  Created by Wilson Beima on 12/5/24.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @State private var imageSize: CGSize = .zero
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @StateObject private var locationManager = LocationManager()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.166032, longitude: -78.159537), span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005))

    
    var body: some View {
        
        ZoomableSwiftImageView(image: Image("Map"),minScale: 1.0,maxScale: 5.0,scale: 4.0)
        ZoomableSwiftImageView(image: Image("Pin"),minScale: 0.3,maxScale: 0.3,scale: 0.3)
        
                
        /*
        NavigationSplitView {
            
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            
            VStack {
                        if let coordinate = locationManager.lastKnownLocation {
                            Text("Latitude: \(coordinate.latitude)")
                            
                            Text("Longitude: \(coordinate.longitude)")
                        } else {
                            Text("Unknown Location")
                        }
                        
                        
                        Button("Get location") {
                            locationManager.checkLocationAuthorization()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
        } detail: {
            Text("Select an item")
        }
         */
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
