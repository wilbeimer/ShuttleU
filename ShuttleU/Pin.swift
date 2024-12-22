//
//  Pin.swift
//  ShuttleU
//
//  Created by Wilson Beima on 12/16/24.
//


import SwiftUI

public struct Pin: View {
    @State private var scale: CGFloat = 0.2
    
    @State private var lastScale: CGFloat = 0.2
    @State private var offset: CGPoint = .zero
    
    @State private var lastTranslation: CGSize = .zero
    
    @Binding private var mapScale: CGFloat
    
    @Binding private var mapOffset: CGPoint
    
    
    @StateObject private var locationManager = LocationManager()
    
    private let centerLat = 39.166032
    private let centerLong = -78.159537
    
    @State private var currentLat: Double = 39.166032
    
    
    var image: Image
    
    public var body: some View {
        ZStack {
            /// CGFloat(locationManager.lastKnownLocation?.latitude ?? centerLat) +
            /// CGFloat(locationManager.lastKnownLocation?.longitude ?? centerLong)  +
            var x = print(CGFloat(locationManager.lastKnownLocation?.longitude ?? centerLong))
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale, anchor: .center)
                .offset(x:  CGFloat(locationManager.lastKnownLocation?.latitude ?? centerLat) + mapOffset.x - centerLat, y: CGFloat(locationManager.lastKnownLocation?.longitude ?? centerLong) + mapOffset.y - centerLong)
                .onTapGesture {
                    currentLat += 20
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            locationManager.checkLocationAuthorization()
        })
    }
    
    public init(image: Image, mapScale: Binding<CGFloat>, mapOffset: Binding<CGPoint>) {
        self.image = image
        self._mapScale = mapScale
        self._mapOffset = mapOffset
    }
}
