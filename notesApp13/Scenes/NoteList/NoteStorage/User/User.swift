//
//  User.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 22.12.24.
//

import Foundation

struct User{
    private(set) var name: String
    private(set) var email: String
    private var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.email == rhs.email && lhs.password == rhs.password
    }
    
}

  
