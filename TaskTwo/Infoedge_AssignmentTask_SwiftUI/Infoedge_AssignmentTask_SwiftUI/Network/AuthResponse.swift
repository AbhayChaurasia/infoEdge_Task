//
//  AuthResponse.swift
//  Infoedge_AssignmentTask_SwiftUI
//
//  Created by Abhay Chaurasia on 16/07/25.
//

import UIKit

class APIService {
    static let baseURL = "https://app.aisle.co/V1"
    
    // Generic request + decoder
    static func performRequest<T: Decodable>(
        type: T.Type,
        request: URLRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let config = URLSessionConfiguration.ephemeral
        
        config.timeoutIntervalForResource = 60
        config.timeoutIntervalForRequest = 30
        let session = URLSession(configuration: config)
        
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print(String(data : data! , encoding: .utf8) ?? "")
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }
            
            do {
                print(String(data : data , encoding: .utf8) ?? "")
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func sendPhoneNumber(_ number: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/phone_number_login") else { return }
        print("Url of otp == \(url)")
        var request = URLRequest(url: url)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "number=\(number)".data(using: .utf8)
        
        session.dataTask(with: request) { _, response, error in
            let success = (response as? HTTPURLResponse)?.statusCode == 200 && error == nil
            completion(success)
        }.resume()
    }
    
    static func verifyOTP(_ number: String, otp: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/verify_otp") else { return }
        print("Url of otp == \(url)")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = OTPRequest(number: number, otp: otp)
        request.httpBody = try? JSONEncoder().encode(body)
        performRequest(type: AuthResponse.self, request: request) { result in
            switch result {
            case .success(let response):
                completion(response.token)
            case .failure:
                completion(nil)
            }
        }
    }
    
    static func fetchNotes(token: String, completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/test_profile_list") else { return }
        var request = URLRequest(url: url)
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        performRequest(type: NotesResponse.self, request: request) { result in
            switch result {
            case .success(let response):
                let names = response.invites.profiles.map { $0.general_information.first_name }
                completion(names)
            case .failure:
                completion([])
            }
        }
    }
    
}

extension APIService {
    static func fetchNotes(token: String, completion: @escaping (Result<NotesResponse, Error>) -> Void) {
        guard let url = URL(string: "https://app.aisle.co/V1/users/test_profile_list") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        performRequest(type: NotesResponse.self, request: request, completion: completion)
    }
}

