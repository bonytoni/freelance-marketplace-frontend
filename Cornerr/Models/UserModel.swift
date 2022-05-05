//
//  UserModel.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import Foundation

struct User: Codable {
    
    let id: Int
    let username: String
    let name: String
    let contact: String
    let bio: String
    let pfp: String
    let seller_listings: [SimpleListing]
    let buyer_listings: [SimpleListing]
    
    init(id: Int, username: String, name: String, contact: String, bio: String, pfp: String, seller_ls: [SimpleListing], buyer_ls: [SimpleListing]) {
        
        self.id = id
        self.username = username
        self.name = name
        self.contact = contact
        self.bio = bio
        self.pfp = pfp
        self.seller_listings = seller_ls
        self.buyer_listings = buyer_ls
        
    }

}

struct SimpleUser: Codable {
    
    let id: Int
    let username: String
    let contact: String
    
    init(id: Int, username: String, contact: String) {
        
        self.id = id
        self.username = username
        self.contact = contact
        
    }

}

struct UserResponse: Codable {
    
    let session_token: String
    let session_expiration: String
    let update_token: String
    
    init(session_token: String, session_expiration: String, update_token: String) {
        
        self.session_token = session_token
        self.session_expiration = session_expiration
        self.update_token = update_token
        
    }
    
}
