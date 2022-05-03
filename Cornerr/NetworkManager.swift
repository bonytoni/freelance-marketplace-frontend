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
    
}
