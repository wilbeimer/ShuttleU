//
//  DriverView.swift
//  ShuttleU
//
//  Created by Wilson Beima on 1/3/25.
//

import SwiftUI

struct DriverView: View {
    @State private var authenticated: Bool = false
    @State private var outcome: Bool = true
    
    @State private var id: String = ""
    @State private var password_attempt: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                if (!authenticated){
                    Color.primaryBlue
                    
                    VStack(alignment: .center){
                        PasswordSecureField($id, $password_attempt,$authenticated,$outcome)
                    }
                    .frame(width: 300, height: 150)
                    
                    NavigationLink(destination: CreateAccount()){
                        Text("Create Account")
                    }
                    .buttonStyle(GrowingButton())
                    .padding()
                    
                } else{
                    MapView()//image: Image("Map"),minScale: 1.0,maxScale: 5.0,scale: 3.0
                }
                
                if (!outcome) {
                    PrestyledText("Incorrect username or password, try again.", Color.white)
                }
            }
            .background(.primaryBlue)
        }
    }

}

struct PasswordSecureField: View {
    @Binding private var text: String
    @Binding private var password: String
    @Binding private var authenticated: Bool
    @Binding private var outcome: Bool
    @State private var user: User?

    init( _ text: Binding<String>, _ password: Binding<String>, _ authenticated: Binding<Bool>, _ outcome: Binding<Bool>) {
        self._text = text
        self._password = password
        self._authenticated = authenticated
        self._outcome = outcome
    }

    var body: some View {
        VStack {
            Form{
                TextField(text: $text, prompt: Text("Required")
                    .foregroundStyle(.white)) {
                        Text("id")
                            .foregroundStyle(Color("PrimaryBlue"))
                    }
                    .textFieldStyle(PrestyledField(icon: Image(systemName: "person")))
                
                SecureField(text: $password, prompt: Text("Required")
                    .foregroundStyle(.white)) {
                        Text("Pasword")
                            .foregroundStyle(Color("PrimaryBlue"))
                    }
                    .textFieldStyle(PrestyledField(icon: Image(systemName: "lock")))
            }
            .scrollContentBackground(.hidden)
            .onSubmit {
                CheckPassword(text, password)
            }
        }
    }
    
    
    func CheckPassword(_ id: String, _ password_attempt: String) {        Task { @MainActor in
            do {
                print("getting user info")
                user = try await getUser(id: id)
            } catch LoginError.invalidURL{
                print("invalid url")
            } catch LoginError.invalidData{
                print("invalid data")
            } catch LoginError.invalidResponse{
                print("invalid response")
            } catch {
                print("unexpevted error")
            }
        
            let password = user?.password
            
            if (password_attempt == password){
                authenticated = true
                outcome = true
            }
            else{
                outcome = false
            }
        }
    }
}

struct PrestyledField: TextFieldStyle {
    @State var icon: Image?
        
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            if icon != nil {
                icon
                    .foregroundColor(.white)
            }
            configuration
        }
        .padding(10)
        .background(.primaryRed)
        .foregroundStyle(.white)
        .listRowBackground(Color.primaryBlue)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    DriverView()
}
