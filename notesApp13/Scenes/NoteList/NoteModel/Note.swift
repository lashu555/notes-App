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
    private(set) var body: String
    private(set) var createdAt: Date
    private(set) var editedAt: Date?
    
    init(id: UUID, title: String, body: String, createdAt: Date, editedAt: Date? = nil) {
        self.id = id
        self.title = title
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

extension NoteDataSource {
    func editedNote(id: UUID, title: String, body: String, editedAt: Date) {
        guard let index = NoteDataSource.shared.notes.firstIndex(where: { $0.id == id }) else {
            print("Note with ID \(id) not found")
            return
        }

        var note = NoteDataSource.shared.notes[index]
        note.update(title: title, body: body, editedAt: editedAt)
        NoteDataSource.shared.notes[index] = note
        
        NoteDataSource.shared.notes.sort(by: { $0.editedAt ?? $0.createdAt > $1.editedAt ?? $1.createdAt })
        
        print("Note updated successfully")
    }
}
