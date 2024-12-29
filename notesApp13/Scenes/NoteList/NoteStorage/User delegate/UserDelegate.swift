//
//  UserDelegate.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 29.12.24.
//

import Foundation
protocol UserDelegate: AnyObject {
    func didreceiveUser(_ user: User)
}
