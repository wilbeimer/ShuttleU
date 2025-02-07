//
//  StudentView.swift
//  ShuttleU
//
//  Created by Wilson Beima on 1/3/25.
//
import SwiftUI

public struct StudentView: View {
    public var body: some View {
        VStack{
            ZStack{
                MapView()//image: Image("Map"),minScale: 1.0,maxScale: 5.0,scale: 3.0
            }
        }
        .background(.primaryBlue)
    }
}

#Preview {
    StudentView()
}
