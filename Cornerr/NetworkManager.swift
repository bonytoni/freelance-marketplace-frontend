//
//  NetworkManager.swift
//  Cornerr
//
//  Created by Jennifer Gu on 5/3/22.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "https://localhost:5000"
    
    static func getAllListings(completion: @escaping ([Listing]) -> Void) {
        let endpt = "\(host)/listings/"
        
        AF.request(endpt, method: .get).validate().responseData { response in
            switch response.result {
            
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode([Listing].self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getListingById(id: Int, completion: @escaping (Listing) -> Void) {
        let endpt = "\(host)/listings/\(id)/"
        
        AF.request(endpt, method: .get).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((Listing).self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    static func createListing(title: String, category: String, description: String, availability: String, location: String, price: Int, seller_id: Int, completion: @escaping (Listing) -> Void) {
        let endpt = "\(host)/listings/\(seller_id)/"
        
        let params = [
            "title": title,
            "category": category,
            "description": description,
            "availability": availability,
            "location": location,
            "price": price,
            "seller_id": seller_id
        ] as [String : Any]
        
        AF.request(endpt, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((Listing).self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    static func deleteListing(id: Int, completion: @escaping (Listing) -> Void) {
        let endpt = "\(host)/listings/\(id)/"
        
        AF.request(endpt, method: .delete).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((Listing).self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    static func createUser(username: String, password: String, contact: String, completion: @escaping (User) -> Void) {
        let endpt = "\(host)/users/"
        
        let params = [
            "username": username,
            "password": password,
            "contact": contact
        ]
        
        AF.request(endpt, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((User).self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    static func getUserById(id: Int, completion: @escaping (User) -> Void) {
        let endpt = "\(host)/users/\(id)/"
        
        AF.request(endpt, method: .get).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((User).self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    static func login(username: String, password: String, completion: @escaping (User) -> Void) {
        let endpt = "\(host)/login/"
        
        let params = [
            "username": username,
            "password": password
        ]
        
        AF.request(endpt, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((User).self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    static func purchaseListing(listing_id: Int, user_id: Int, completion: @escaping (User) -> Void) {
        let endpt = "\(host)/listings/\(listing_id)/\(user_id)/purchase/"
        
        AF.request(endpt, method: .post).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((User).self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
    }
    
}
