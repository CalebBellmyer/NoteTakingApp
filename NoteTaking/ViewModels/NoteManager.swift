//
//  NoteManager.swift
//  NoteTaking
//
//  Created by Caleb Bellmyer on 2/13/25.
//

import SwiftUI
import Foundation

class NoteManager: ObservableObject {
    @Published var notes: [NoteModel] = [] {
        didSet {
            saveNotes()
        }
    }
    
    @AppStorage("notes") private var notesData: String = "[]"
    
    init() {
        loadNotes()
    }
    
    private func saveNotes() {
        do {
            let data = try JSONEncoder().encode(notes)
            notesData = String(data: data, encoding: .utf8) ?? "[]"
        } catch {
            print("Error saving notes: \(error.localizedDescription)")
        }
    }
    
    // Loads Notes
    func loadNotes() {
        if let data = notesData.data(using: .utf8) {
            do {
                let decodedNotes = try JSONDecoder().decode([NoteModel].self, from: data)
                notes = decodedNotes
            } catch {
                print("Error loading notes: \(error.localizedDescription)")
            }
        }
    }
    
    // Adds a new note.
    func addNote(_ note: NoteModel) {
        notes.append(note)
    }
    
    // Updates an existing note, matching by UUID.
    func updateNote(updatedNote: NoteModel) {
        if let index = notes.firstIndex(where: { $0.id == updatedNote.id }) {
            notes[index] = updatedNote
        }
    }
    
    // Deletes a note based on its UUID.
    func deleteNote(_ note: NoteModel) {
        notes.removeAll { $0.id == note.id }
    }
}
