//
//  Note.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import Foundation

struct Note{
    var id: UUID
    var title: String
    var body: String
    var createdAt: Date
    var editedAt: Date?
    init(id: UUID, title: String, body: String, createdAt: Date, editedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.editedAt = editedAt
    }
    
    
}
