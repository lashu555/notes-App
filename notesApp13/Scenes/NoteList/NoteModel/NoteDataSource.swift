//
//  NoteDataSource.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import Foundation

struct NoteDataSource {
    static var shared = NoteDataSource()
    var notes = [
        Note(id: UUID(), title: "Grocery ListLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", body: "Milk, eggs, bread, cheese, apples", createdAt: Date()),
        Note(id: UUID(), title: "Meeting Notes", body: "Discuss Q1 project timeline and budget", createdAt: Date()),
        Note(id: UUID(), title: "Weekend Plans", body: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", createdAt: Date())
    ]
    mutating func editedNote(id: UUID, title: String, body: String, editedAt: Date) {
        DispatchQueue.main.async {
            for (index, note) in NoteDataSource.shared.notes.enumerated() {
                if note.id == id {
                    NoteDataSource.shared.notes[index].title = title
                    NoteDataSource.shared.notes[index].body = body
                    NoteDataSource.shared.notes[index].createdAt = editedAt
                    print("did update note")
                    break
                }
            }
        }}
}
