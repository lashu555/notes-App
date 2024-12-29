//
//  NoteStorage.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 10.12.24.
//

import Foundation

class NoteStorage {
    private let storageKey = "notesKey"
    
    static let shared = NoteStorage()
    private init() {}
    func saveNotes(_ notes: [Note]) {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    func loadNotes(_ user: User) -> [Note] {
            guard let data = UserDefaults.standard.data(forKey: storageKey),
                  let decoded = try? JSONDecoder().decode([Note].self, from: data) else {
                return []
            }
        return decoded.filter { $0.author == user }
        }
}
