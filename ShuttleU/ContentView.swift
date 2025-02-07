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
    @State private var driver: Bool = false
    @State private var mode: String = "Student"
    
    var body: some View {
        ZStack{
            if (!driver){
                StudentView()
                    .onAppear(
                        perform: {
                            mode = "Student"
                        }
                    )
            }
            else{
                DriverView()
                    .onAppear(
                        perform: {
                            mode = "Driver"
                        }
                    )
            }
            
            HStack(alignment: .top){
                Spacer()
                
                VStack(alignment: .trailing,spacing: 0){
                    Button(action: {
                        driver.toggle()
                    }, label: {
                        Text("Mode")
                    })
                    .buttonStyle(GrowingButton())
                    
                    PrestyledText(mode)
                    
                    Spacer()
                }
                .padding(.trailing,15)
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
    private var text: String
    private var color: Color

    init(_ text: String,_ color: Color = Color.primaryRed) {
        self.text = text
        self.color = color
    }

    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.title)
            .bold()
            //.background(.primaryRed, in: RoundedRectangle(cornerRadius: 15))
    }
}


#Preview {
    ContentView()
}

