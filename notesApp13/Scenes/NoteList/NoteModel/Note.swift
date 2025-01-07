//
//  Note.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import Foundation

struct Note: Codable {
    private(set) var id: UUID
    private(set) var title: String
    private(set) var author: User
    private(set) var body: String
    private(set) var createdAt: Date
    private(set) var editedAt: Date?
    
    init(id: UUID, title: String, author: User, body: String, createdAt: Date, editedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.body = body
        self.createdAt = createdAt
        self.editedAt = editedAt
    }
    
    mutating func update(title: String, body: String, editedAt: Date) {
        self.title = title
        self.body = body
        self.editedAt = editedAt
    }
}
