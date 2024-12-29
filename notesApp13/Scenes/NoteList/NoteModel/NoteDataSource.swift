//
//  NoteDataSource.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import Foundation

class NoteDataSource {
    static var shared = NoteDataSource()
    private init() {
        let savedNotes = NoteStorage.shared.loadNotes(UserDataSource.shared.users.first!)
        if savedNotes.isEmpty {
            self.notes = [
                Note(id: UUID(), title: "Grocery List", author: UserDataSource.shared.users.first!, body: "Milk, eggs, bread, cheese, apples", createdAt: Date()),
                Note(id: UUID(), title: "Meeting Notes", author: UserDataSource.shared.users.first!, body: "Discuss Q1 project timeline and budget", createdAt: Date()),
                Note(id: UUID(), title: "Weekend Plans", author: UserDataSource.shared.users.first!, body: "Plan for hiking and movie night", createdAt: Date())
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
