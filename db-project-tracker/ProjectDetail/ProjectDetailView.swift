//
//  ProjectDetailView.swift
//  db-project-tracker
//
//  Created by MacBook2014 on 4/15/24.
//

import SwiftUI

struct ProjectDetailView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  var project: Project
  
  var body: some View {
    
    VStack {
      
      Text(project.name)
        .navigationBarBackButtonHidden(true)
      
      Button("Back") {
        // navigate back
        dismiss()
      }

    }
  }
}

#Preview {
  ProjectDetailView(project: Project())
}
