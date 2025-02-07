//
//  Requests.swift
//  ShuttleU
//
//  Created by Wilson Beima on 2/4/25.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let password: String
}

func getUser(id: String) async throws -> User {
    print("id: ", id)
    let endpoint = "https://restapi-bctf.onrender.com/user/" + id
    print("endpoint: ", endpoint)
    
    guard let url = URL(string: endpoint) else {
        throw LoginError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw LoginError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("Call success")
        return try decoder.decode(User.self, from: data)
    } catch {
        throw LoginError.invalidData
    }
}

func createUser(id: Int,username: String, password: String) async throws {
    print("username: ", username)
    print("password: ", password)
    print("id: ", id)
    
    let json: [String: Any] = ["id": id,
                               "username": username,
                               "password": password]

    // Convert the dictionary to JSON data
    guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
        throw LoginError.invalidData
    }

    // URL of the API endpoint
    guard let url = URL(string: "https://restapi-bctf.onrender.com/user/" + String(id)) else {
        throw LoginError.invalidURL
    }

    // Create a URLRequest and configure it for a PUT request
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    // Create a URLSession data task to send the request
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        // Check the response status code
        if let httpResponse = response as? HTTPURLResponse {
            if (200...299).contains(httpResponse.statusCode) {
                // Success
                print("Success: \(httpResponse.statusCode)")
            } else {
                // Failure
                print("Failed with status code: \(httpResponse.statusCode)")
            }
        }
        
        // Optional: Handle response data if needed
        if let data = data {
            // You can parse the response data here if necessary
            print("Response data: \(data)")
        }
    }

    // Start the task
    task.resume()

}

enum LoginError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
