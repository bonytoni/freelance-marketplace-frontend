//
//  NetworkManager.swift
//  Cornerr
//
//  Created by Jennifer Gu on 5/3/22.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "http://34.152.43.79/"
    
    static func getAllListings(completion: @escaping ([Listing]) -> Void) {
        let endpt = "\(host)/listings/"
        
        AF.request(endpt, method: .get).validate().responseData { response in
            switch response.result {
            
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode(ListingResponse.self, from: data) {
                    completion(userResponse.listings)
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
    
    static func createListing(title: String, category: String, description: String, availability: String, location: String, price: Int, picture: String, seller_id: Int, token: String, completion: @escaping (Listing) -> Void) {
        let endpt = "\(host)/listings/\(seller_id)/"
        
        let params = [
            "title": title,
            "category": category,
            "description": description,
            "availability": availability,
            "location": location,
            "price": price,
            "picture": picture,
            "seller_id": seller_id
        ] as [String : Any]
        
        AF.request(endpt, method: .post, parameters: params, encoding: JSONEncoding.default, headers: authHeader(token: token)).validate().responseData { response in
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
    
    static func editListing(title: String, category: String, description: String, availability: String, location: String, price: Int, picture: String, seller_id: Int, token: String, completion: @escaping (Listing) -> Void) {
        let endpt = "\(host)/listings/edit/\(seller_id)/"
        
        let params = [
            "title": title,
            "category": category,
            "description": description,
            "availability": availability,
            "location": location,
            "price": price,
            "picture": picture,
            "seller_id": seller_id
        ] as [String : Any]
        
        AF.request(endpt, method: .post, parameters: params, encoding: JSONEncoding.default, headers: authHeader(token: token)).validate().responseData { response in
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
    
    static func createUser(username: String, password: String, name: String, contact: String, completion: @escaping (UserResponse) -> Void) {
        let endpt = "\(host)/users/"
        
        let params = [
            "username": username,
            "password": password,
            "name": name,
            "contact": contact
        ]
        
        AF.request(endpt, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((UserResponse).self, from: data) {
                    completion(userResponse)
                }
              
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    static func getUserById(id: Int, token: String, completion: @escaping (User) -> Void) {
        let endpt = "\(host)/users/\(id)/"
        
        AF.request(endpt, method: .get, headers: authHeader(token: token)).validate().responseData { response in
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
    
    static func login(username: String, password: String, completion: @escaping (String) -> Void) {
        let endpt = "\(host)/login/"
        
        let params = [
            "username": username,
            "password": password
        ]
        
        AF.request(endpt, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jd = JSONDecoder()
                if let userResponse = try? jd.decode((UserResponse).self, from: data) {
                    completion(userResponse.session_token)
                    print(userResponse)
                }
              
            case .failure(let error):
                completion("Invalid")
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
    
    class func authHeader(token: String) -> HTTPHeaders {
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        return header
    }
    
}
