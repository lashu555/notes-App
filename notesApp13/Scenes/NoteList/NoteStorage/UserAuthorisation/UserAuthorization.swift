//
//  UserAuthorization.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 21.12.24.
//

import Foundation

class UserAuthorization{
    static let shared = UserAuthorization()
    private let storageKey = "userAuthorization"
    private init(){}
    var isAuthorized: Bool{
        get{
            UserDefaults.standard.bool(forKey: storageKey)
        }set{
            UserDefaults.standard.set(newValue, forKey: storageKey)
        }
    }
}
