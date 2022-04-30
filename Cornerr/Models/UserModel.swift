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
    let contact: String
    let seller_listings: [Listing]
    let buyer_listings: [Listing]
    
    init(id: Int, username: String, contact: String, seller_ls: [Listing], buyer_ls: [Listing]) {
        
        self.id = id
        self.username = username
        self.contact = contact
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