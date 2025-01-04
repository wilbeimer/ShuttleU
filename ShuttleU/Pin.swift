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
    
    private let centerLat: Double =  39.163279386449105 //39.166032000000000000
    private let centerLong: Double = -78.1573240365834 //-78.159537000000000000
    private let latConversion: Double = 0.00001607
    private let longConversion: Double = -0.00001253
    
    @State private var currentLat: Double =  39.15994394009731
    @State private var currentLong: Double =  -78.15255163237462
    
    
    private var image: Image
    
    public var body: some View {
        ZStack {
            /// CGFloat(locationManager.lastKnownLocation?.latitude ?? centerLat)  * (0.00001647)+ mapOffset.x - centerLat
            /// CGFloat(locationManager.lastKnownLocation?.longitude ?? centerLong) * (-0.00001278)  + mapOffset.y - centerLong
            //var _ = print("Pin x: \((( currentLat - centerLat) / latConversion) + mapOffset.x)", "pin y \((( currentLong - centerLong) / longConversion) + mapOffset.y)")
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale, anchor: .center)
                .offset(x:  ((currentLat - centerLat) / latConversion) + mapOffset.x , y: ((currentLong - centerLong) / longConversion) + mapOffset.y)
                .onTapGesture {
                    print(offset.x,offset.y)
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
