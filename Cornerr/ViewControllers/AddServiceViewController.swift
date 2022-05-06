//
//  AddServiceViewController.swift
//  Cornerr
//
//  Created by Tony Chen on 5/6/22.
//

import UIKit

class AddServiceViewController : UIViewController {
    
    private var currentUser: User
    private var currentToken: String
    
    init(user: User, token: String) {
        self.currentUser = user
        self.currentToken = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
    }
    
}
