//
//  CreateAccount.swift
//  ShuttleU
//
//  Created by Wilson Beima on 2/5/25.
//

import SwiftUI

struct CreateAccount: View {
    @State public var id: String = ""
    @State public var username: String = ""
    @State public var password: String = ""
    
    var body: some View {
        VStack(alignment: .center){
            Color.primaryBlue
            
            Form{
                TextField(text: $id, prompt: Text("Required")
                    .foregroundStyle(.white)) {
                        Text("id")
                            .foregroundStyle(Color("PrimaryBlue"))
                    }
                    .textFieldStyle(PrestyledField(icon: Image(systemName: "person")))
                
                TextField(text: $username, prompt: Text("Required")
                    .foregroundStyle(.white)) {
                        Text("username")
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
                self.Create(Int(id) ?? 0, username, password)
            }
        }
        .background(.primaryBlue)
    }
        
    func Create(_ id: Int, _ username: String, _ password: String) {
        Task { @MainActor in
            do {
                print("creating user info")
                let user = try await createUser(id: id, username: username, password: password)
                print(user)
            } catch LoginError.invalidURL{
                print("invalid url")
            } catch LoginError.invalidData{
                print("invalid data")
            } catch LoginError.invalidResponse{
                print("invalid response")
            } catch {
                print("unexpected error")
            }
        }
    }
}

#Preview {
    CreateAccount()
}
