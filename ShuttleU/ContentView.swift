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
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.166032, longitude: -78.159537), span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005))

    var body: some View {
        
        ///Image("Map")        
        
        Map(image: Image("Map"),minScale: 1.0,maxScale: 5.0,scale: 3.0)
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

