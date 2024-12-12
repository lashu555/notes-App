//
//  Note.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import Foundation

struct Note: Codable{
    fileprivate var id: UUID
    fileprivate var title: String
    fileprivate var body: String
    fileprivate var createdAt: Date
    fileprivate var editedAt: Date?
    init(id: UUID, title: String, body: String, createdAt: Date, editedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.editedAt = editedAt
    }
    func getId() -> UUID {
        return id
    }
    func getTitle() -> String {
        return title
    }
    func getBody() -> String {
        return body
    }
    func getCreatedAt() -> Date {
        return createdAt
    }
}
extension NoteDataSource{
    mutating func editedNote(id: UUID, title: String, body: String, editedAt: Date) {
        DispatchQueue.main.async {
            var notes = NoteDataSource.shared.notes
            if let index = notes.firstIndex(where: { $0.id == id }) {
                var updatedNote = notes[index]
                updatedNote.title = title
                updatedNote.body = body
                updatedNote.createdAt = editedAt
                notes[index] = updatedNote
                notes.remove(at: index)
                notes.insert(updatedNote, at: 0)
                NoteDataSource.shared.notes = notes
                print("Note updated successfully")
            } else {
                print("Note with ID \(id) not found")
            }
        }
    }
}
