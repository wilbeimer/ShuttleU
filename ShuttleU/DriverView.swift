//
//  DriverView.swift
//  ShuttleU
//
//  Created by Wilson Beima on 1/3/25.
//

import SwiftUI

struct DriverView: View {
    @State private var authenticated: Bool = false
    
    @State private var password_attempt: String = ""
    
    var body: some View {
        VStack{
            if (!authenticated){
                VStack(alignment: .center){
                    PrestyledText("Driver")
                    PasswordSecureField($password_attempt,$authenticated)
                }
                .frame(width: 300, height: 150)
            } else{
                Map(image: Image("Map"),minScale: 1.0,maxScale: 5.0,scale: 3.0)
            }
        }
        .background(.primaryBlue)
    }
}

#Preview {
    DriverView()
}
