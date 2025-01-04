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
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.166032, longitude: -78.159537), span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005))
    
    @State private var driver: Bool = false

    var body: some View {
        ///Map(image: Image("Map"),minScale: 1.0,maxScale: 5.0,scale: 3.0)
        
        ZStack{
            if (!driver){
                StudentView()
            }
            else{
                DriverView()
            }
            
            VStack{
                HStack{
                    Spacer()
                    
                    Button(action: {
                        driver.toggle()
                    }, label: {
                        Text("Mode")
                    })
                    .buttonStyle(GrowingButton())
                    .padding(.trailing,15)
                }
                Spacer()
            }
        }
        .background(.primaryBlue)
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(.primaryRed)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct PrestyledText: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .padding(10)
            .foregroundColor(.white)
            .font(.title)
    }
}

struct PasswordSecureField: View {
    @Binding private var text: String
    @Binding private var authenticated: Bool

    init( _ text: Binding<String>, _ authenticated: Binding<Bool>) {
        self._text = text
        self._authenticated = authenticated
    }

    var body: some View {
        SecureField(text: $text, prompt: Text("Required")
        .foregroundStyle(.white)) {
            Text("Pasword")
                .foregroundStyle(Color("PrimaryBlue"))
        }
        .padding(10)
        .onSubmit {
            CheckPassword(text)
        }
        .background(.primaryRed)
        .foregroundStyle(.white)
    }
    
    
    func CheckPassword(_ password_attempt: String){
        let password: String = "hello"
        if (password_attempt == password){
            authenticated = true
        }
    }
}

#Preview {
    ContentView()
}

