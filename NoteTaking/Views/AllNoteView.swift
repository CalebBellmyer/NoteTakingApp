//
//  AllNoteView.swift
//  NoteTaking
//
//  Created by Caleb Bellmyer on 2/13/25.
//

import SwiftUI

struct AllNoteView: View {
    @ObservedObject private var noteManager = NoteManager()
    
    init(noteManager: NoteManager = NoteManager()) {
        self.noteManager = noteManager
    }
    @State private var showNoteView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("All Notes")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        showNoteView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                // Open the Note Creation View
                .sheet(isPresented: $showNoteView, onDismiss: {
                    noteManager.loadNotes()
                }) {
                    NoteCreationView(noteManager: noteManager)
                }
                
                // Notes Display
                ScrollView {
                    LazyVStack(spacing: 12) {
                        if noteManager.notes.isEmpty {
                            Text("No saved notes.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(noteManager.notes, id: \.id) { note in
                                NavigationLink(destination: NoteDetailView(noteManager: noteManager, note: note)) {
                                    NoteCard(note: note)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 8)
                }
                
                Spacer()
            }
            .onAppear {
                noteManager.loadNotes()
            }
            .navigationTitle("")
        }
    }
}

struct NoteCard: View {
    var note: NoteModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(note.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .strikethrough(note.isCompleted, color: .green)
                    .foregroundColor(note.isCompleted ? .green : .black)
                Text("Created \(note.dateCreated.formatted(.dateTime.month(.abbreviated).day().year()))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                if note.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .accessibilityLabel("Completed")
                        .accessibilityHint("This note is marked as completed")
                }
            }
            



            Divider()
            
            Text(note.content)
                .font(.body)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(3)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(radius: 3))
    }
}

#Preview {
    AllNoteView()
}

