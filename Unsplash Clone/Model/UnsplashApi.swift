//
//  Unsplash API Response.swift
//  Unsplash Clone
//
//  Created by Gavin Brown on 3/12/23.
//

import Foundation



struct UnsplashResponse: Codable, Identifiable {
    let id: String
    let urls: Photo_URLS
    let user: User_Info
    let description: String?
}

struct Photo_URLS: Codable {
     let raw: String
     let full: String
     let regular: String
     let small: String
     let thumb: String
}

struct User_Info: Codable {
     let id: String
     let name: String
     let bio: String?
     let links: User_Links
    
}

struct User_Links:Codable {
     let photos: String
}

enum URLRequestError: Error {
      case requestFailed
      case requestDecodingFailed
      case urlCreationFailed
      case keyNotFound
  }

struct UnsplashApi {
    let session = URLSession(configuration: .default)
    let decoder = JSONDecoder()
    
    // MARK: Since the data returned is an Array we need to add that in the Decoder and returned value
    func randomPhotos() async throws -> [UnsplashResponse]  {
        guard let unsplash_auth_key = ProcessInfo.processInfo.environment["UNSPLASH_API"] else {
            throw URLRequestError.keyNotFound
        }
       guard let url = URL(string: "https://api.unsplash.com/photos/random/?client_id=\(unsplash_auth_key)&count=10") else {
           throw URLRequestError.urlCreationFailed
       }

            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                throw URLRequestError.requestFailed
            }
        
         guard let unsplashAPIResponse = try? decoder.decode([UnsplashResponse].self, from: data) else {
             if let debugString = String(data: data, encoding: .utf8) {
                 print(debugString)
             }
                throw URLRequestError.requestDecodingFailed
            }
        
        return unsplashAPIResponse
        
    }
}

