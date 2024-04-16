//
//  Project.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/13/24.
//

import Foundation
import SwiftData

@Model
class Project: Identifiable {
  
  @Attribute(.unique) var id: String
  var name: String
  var startDate: Date
  var focus: String
  @Relationship(deleteRule: .cascade, inverse: \ProjectUpdate.project)
  var updates: [ProjectUpdate]
  
  init() {
    
    id = UUID().uuidString
    name = ""
    startDate = Date()
    focus = ""
    updates = [ProjectUpdate]()
  }
}
