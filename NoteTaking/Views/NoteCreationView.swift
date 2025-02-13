//
//  NoteCreationView.swift
//  NoteTaking
//
//  Created by Caleb Bellmyer on 2/14/25.
//

import SwiftUI

struct NoteCreationView: View {
    @ObservedObject var noteManager: NoteManager
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Create Note")) {
                    TextField("Title", text: $title)
                        .accessibilityLabel("Note Title")
                        .accessibilityHint("Enter the title of the note")
                    
                    TextField("Note", text: $text)
                        .accessibilityLabel("Note Content")
                        .accessibilityHint("Enter the content of your note")
                    
                    Button("Save Note") {
                        let note = NoteModel(title: title, content: text)
                        noteManager.addNote(note)
                        showAlert = true
                    }
                    .accessibilityLabel("Save Note")
                    .accessibilityHint("Saves your note and returns to the previous screen")
                    
                    .alert("Note Saved!", isPresented: $showAlert) {
                        Button("OK", role: .cancel) {
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NoteCreationView(noteManager: NoteManager())
}

