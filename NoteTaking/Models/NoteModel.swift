//
//  NoteModel.swift
//  NoteTaking
//
//  Created by Caleb Bellmyer on 2/13/25.
//

import Foundation

struct NoteModel: Codable, Identifiable {
    let id: UUID
    var title: String
    var content: String
    var isCompleted: Bool
    let dateCreated: Date
    

    init(id: UUID = UUID(), title: String, content: String, isCompleted: Bool = false, dateCreated: Date = Date()) {
        self.id = id
        self.title = title
        self.content = content
        self.isCompleted = isCompleted
        self.dateCreated = dateCreated
    }
    
}
