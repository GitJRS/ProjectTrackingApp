//
//  DBProjectTracker.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/13/24.
//

import SwiftUI
import SwiftData

@main
struct DBProjectTracker: App {
    var body: some Scene {
        WindowGroup {
            ProjectListView()
            .modelContainer(for: [Project.self, ProjectUpdate.self])
        }
    }
}
