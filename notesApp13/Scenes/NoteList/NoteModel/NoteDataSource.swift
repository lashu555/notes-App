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

}
