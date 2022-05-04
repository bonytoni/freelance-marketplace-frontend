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
    let seller_listings: [SimpleListing]
    let buyer_listings: [SimpleListing]
    
    init(id: Int, username: String, name: String, contact: String, bio: String, seller_ls: [SimpleListing], buyer_ls: [SimpleListing]) {
        
        self.id = id
        self.username = username
        self.name = name
        self.contact = contact
        self.bio = bio
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
