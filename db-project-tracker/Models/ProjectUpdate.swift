//
//  ProjectUpdate.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/13/24.
//

import Foundation
import SwiftData

@Model
class ProjectUpdate: Identifiable {
  
  @Attribute(.unique) var id: String
  var headline: String
  var summary: String
  var date: Date
  var hours: Double
  var updateType: UpdateType
  var project: Project?
  
  init() {
    
    id = UUID().uuidString
    headline = ""
    summary = ""
    date = Date()
    hours = 0.0
    updateType = UpdateType.log
    
  }
}

enum UpdateType: Codable {
  
  case log, milestone
  
}
