//
//  NoteDataSource.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import Foundation

struct NoteDataSource {
    static var shared = NoteDataSource()
    private init() {
        let savedNotes = NoteStorage.shared.loadNotes()
        if savedNotes.isEmpty {
            self.notes = [
                Note(id: UUID(), title: "Grocery List", body: "Milk, eggs, bread, cheese, apples", createdAt: Date()),
                Note(id: UUID(), title: "Meeting Notes", body: "Discuss Q1 project timeline and budget", createdAt: Date()),
                Note(id: UUID(), title: "Weekend Plans", body: "Plan for hiking and movie night", createdAt: Date())
            ]
        } else {
            self.notes = savedNotes
        }
    }

    var notes: [Note] {
            didSet {
                NoteStorage.shared.saveNotes(notes)
            }
        }
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
