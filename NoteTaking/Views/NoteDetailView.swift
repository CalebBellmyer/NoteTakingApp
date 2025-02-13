//
//  File.swift
//  NoteTaking
//
//  Created by Caleb Bellmyer on 2/14/25.
//

import SwiftUI

struct NoteDetailView: View {
    @ObservedObject var noteManager: NoteManager
    @State private var title: String
    @State private var content: String
    @State private var isCompleted: Bool
    var note: NoteModel
    @Environment(\.dismiss) var dismiss

    init(noteManager: NoteManager, note: NoteModel) {
        self.noteManager = noteManager
        self.note = note
        _title = State(initialValue: note.title)
        _content = State(initialValue: note.content)
        _isCompleted = State(initialValue: note.isCompleted)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Edit Note")) {
                    TextField("Title", text: $title)
                        .accessibilityLabel("Edit Note Title")
                        .accessibilityHint("Modify the title of your note")

                    TextEditor(text: $content)
                        .frame(height: 400)
                        .accessibilityLabel("Edit Note Content")
                        .accessibilityHint("Modify the content of your note")
                    
                    Toggle("Mark Complete", isOn: $isCompleted)
                        .accessibilityLabel("Mark as Completed")
                        .accessibilityHint("Toggles the note's completion status")
                }
                
                HStack {
                    Button("Save Changes") {
                        let updatedNote = NoteModel(id: note.id,
                                                    title: title,
                                                    content: content,
                                                    isCompleted: isCompleted,
                                                    dateCreated: note.dateCreated)
                        noteManager.updateNote(updatedNote: updatedNote)
                        dismiss() // Close the detail view
                    }
                    .accessibilityLabel("Save Changes")
                    .accessibilityHint("Saves the changes made to your note")
                    .buttonStyle(.borderedProminent)
                    .padding()

                    Button("Delete Note", role: .destructive) {
                        noteManager.deleteNote(note)
                        dismiss()
                    }
                    .accessibilityLabel("Delete Note")
                    .accessibilityHint("Deletes this note permanently")
                    .buttonStyle(.bordered)
                    .padding()
                }
                }
                
            .navigationTitle("Edit Note")
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleNote = NoteModel(title: "Sample Title", content: "Sample content for the note.")
        let manager = NoteManager()
        return NoteDetailView(noteManager: manager, note: sampleNote)
    }
}
