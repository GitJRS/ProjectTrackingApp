//
//  StatHelper.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/17/24.
//

import Foundation
import SwiftUI

struct StatHelper {
  
  // this method should be ran after the new update has been added to the project.updates array
  static func updateAdded(project: Project, update: ProjectUpdate) {
    
    // change hours
    project.hours += update.hours
    
    // change wins
    if update.updateType == .milestone {
      project.wins += 1
    }
    
    // change sessions
    let sortedUpdates = project.updates.sorted {u1, u2 in
      u1.date > u2.date
    }
    if sortedUpdates.count >= 2 {
      //check if latest 2 updates have the same date
      let date1 = sortedUpdates[0].date
      let date2 = sortedUpdates[1].date
      // logically, this should be the same as !Calendar.current.isDate(date1, equalTo: date2, toGranularity: .day)
      if !Calendar.current.isDate(date1, inSameDayAs: date2) {
        // increment sessions if it's a new day
        project.sessions += 1
      }
    } else {
      // since <2 updates, then this is the first of today.
      project.sessions += 1
    }
  }
  
  // run after update has been removed from project.updates array
  static func updateDeleted(project: Project, update: ProjectUpdate) {
    
    // change hours
    project.hours -= update.hours
    
    // change wins
    if update.updateType == .milestone {
      project.wins -= 1
    }
    
    // change sessions
    let sameDayUpdates = project.updates.filter { u in
      Calendar.current.isDate(u.date, inSameDayAs: update.date)
    }
    if sameDayUpdates.count == 0 {
      project.sessions -= 1
    }
  }
  
  static func updateEdited(project: Project, hoursDifference: Double) {
    
    // change hours
    project.hours += hoursDifference
  }
}
