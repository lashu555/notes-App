//
//  UserDataSource.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 22.12.24.
//

import Foundation

class UserDataSource {
    static let shared = UserDataSource()
    let users: [User] = [
        User(name: "lashu", email: "lashu@icloud.com", password: "meowMeow")]
}
